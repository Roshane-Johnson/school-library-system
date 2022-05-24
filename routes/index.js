const express = require('express')
const router = express.Router()
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

module.exports = router
