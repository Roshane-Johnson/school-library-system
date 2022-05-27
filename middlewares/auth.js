function auth(req, res, next) {
	if (req.session.uuid) {
		next()
	} else {
		req.flash('error', 'please login first')
		res.redirect('/login')
	}
}

function adminAuth(req, res, next) {
	if (req.session.u_role == 'admin') {
		next()
	} else {
		res.redirect('/login')
	}
}

module.exports = { auth, adminAuth }
