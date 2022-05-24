function auth(req, res, next) {
	if (req.session.uuid) {
		next()
	} else {
		res.redirect('/login')
	}
}

module.exports = { auth }
