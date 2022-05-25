const express = require('express')
const router = express.Router()
const DB = require('../lib/db')
const { adminAuth } = require('../middlewares/auth')

router.use(adminAuth)

router.get('/books', (req, res) => {
	DB.query('SELECT bh.id, bh.is_approved AS approved, bh.is_returned AS returned, bh.return_dt AS returned_date, bks.bk_title AS title, bks.bk_desc AS description, bks.bk_cover AS cover, bks.author AS writer, bks.quantity AS qty FROM school_library.borrow_history bh JOIN school_library.users usr ON usr.id = bh.user_id JOIN school_library.books bks ON bks.id = bh.book_id WHERE bh.is_approved = 0;', (err, rows) => {
		if (err) throw err

		res.render('admin', { page_title: 'Home', books: rows })
	})
})

module.exports = router
