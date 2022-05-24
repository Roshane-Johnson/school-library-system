const express = require('express')
const router = express.Router()
const DB = require('../../lib/db')
const bcrypt = require('bcrypt')

/**
 * Login
 */
router.post('/login', (req, res) => {
	let { email, password } = {
		email: req.body.email.trim(),
		password: req.body.password.trim(),
	}

	DB.query('SELECT * FROM users WHERE email = ? LIMIT 1;', email, (err, rows) => {
		if (err) throw err

		if (bcrypt.compareSync(password, rows[0].password) && rows.length > 0) {
			req.session.uuid = rows[0].id
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
