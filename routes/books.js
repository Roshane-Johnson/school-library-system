const express = require('express')
const DB = require('../lib/db')
const router = express.Router()
const { auth, adminAuth } = require('../middlewares/auth')

router.get('/', auth, (req, res) => {
	DB.query(
		`SELECT 
			bh.is_approved AS approved,
			bh.is_returned AS returned,
			bh.return_dt AS return_date,
			bks.id,
			bks.bk_title AS title,
			bks.bk_desc AS description,
			bks.bk_cover AS cover,
			bks.author AS writer,
			bks.quantity AS qty
		FROM
			school_library.borrow_history bh
				JOIN
			school_library.users usr ON usr.id = bh.user_id
				JOIN
			school_library.books bks ON bks.id = bh.book_id
		WHERE usr.id = ? AND bh.is_returned = 0;`,
		req.session.uuid,
		(err, rows) => {
			if (err) throw err
			res.render('books', { page_title: 'Books', books: rows })
		}
	)
})

router.post('/request/:id', auth, (req, res) => {
	let book_id = parseInt(req.params.id)
	let data = {
		user_id: req.session.uuid,
		book_id: req.params.id,
		return_dt: new Date(Date.now() + 1209600000).toISOString().slice(0, 19).replace('T', ' '),
	}

	DB.query('INSERT INTO school_library.borrow_history SET ?;', data, (err, results) => {
		if (err) throw err

		DB.query('UPDATE school_library.books SET quantity = (quantity -1) WHERE id = ?;', book_id, (err, rows) => {
			if (err) throw err

			req.flash('success', 'book borrow requested')
			res.redirect('/books')
		})
	})
})

router.post('/return/:id', auth, (req, res) => {
	let book_id = parseInt(req.params.id)
	let user_id = parseInt(req.session.uuid)

	DB.query('UPDATE school_library.borrow_history SET is_returned = 1 WHERE user_id = ? AND book_id = ? AND is_approved = 1;', [user_id, book_id], (err, results) => {
		if (err) throw err

		DB.query('UPDATE school_library.books SET quantity = (quantity +1) WHERE id = ?;', book_id, (err, results) => {
			if (err) throw err

			req.flash('success', 'book borrow requested')
			res.redirect('/books')
		})
	})
})

router.get('/approve/:id', adminAuth, (req, res) => {
	let book_hist_id = parseInt(req.params.id)

	DB.query('UPDATE school_library.borrow_history SET is_approved = 1  WHERE id = ?;', book_hist_id, (err, results) => {
		if (err) throw err

		req.flash('success', 'book approved')
		res.redirect('/books')
	})
})

module.exports = router
