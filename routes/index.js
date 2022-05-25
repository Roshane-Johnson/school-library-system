const express = require('express')
const router = express.Router()
const bcrypt = require('bcrypt')
const DB = require('../lib/db')

router.get('/', (req, res) => {
	DB.query('SELECT bks.id, bks.bk_title AS title, bks.bk_desc AS description, bks.bk_cover AS cover, bks.author AS writer, bks.quantity AS qty, ct.category FROM school_library.books bks, school_library.book_categories ct WHERE bks.category_id = ct.id;', (err, rows) => {
		if (err) throw err

		res.render('index', { page_title: 'Home', books: rows })
	})
})

router.get('/login', (req, res) => {
	res.render('login', { page_title: 'Login' })
})

/*********************
 * 	 API Endpoints
 *********************/

/**
 * Login
 */
router.post('/login', (req, res) => {
	let { email, password } = {
		email: req.body.email.trim(),
		password: req.body.password.trim(),
	}

	DB.query('SELECT * FROM users usr JOIN school_library.roles rls ON rls.id = usr.role_id WHERE usr.email = ? LIMIT 1;', email, (err, rows) => {
		if (err) throw err
		if (bcrypt.compareSync(password, rows[0].password) && rows.length > 0) {
			req.session.uuid = rows[0].id
			req.session.u_role = rows[0].role
			req.flash('success', 'login successful')
			res.redirect('/')
		} else {
			req.flash('error', 'invalid credentials')
			res.redirect('/login')
		}
	})
})

/**
 * Logout
 */
router.get('/logout', (req, res) => {
	req.session.destroy()
	res.redirect('/')
})

module.exports = router
