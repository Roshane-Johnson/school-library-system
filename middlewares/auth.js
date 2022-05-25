function auth(req, res, next) {
	if (req.session.uuid) {
		next()
	} else {
		req.flash('error', 'please login first')
		res.redirect('/login')
	}
}

module.exports = { auth }
