require('dotenv').config()
const express = require('express')
const session = require('express-session')
const expressLayouts = require('express-ejs-layouts')
const cors = require('cors')
const path = require('path')
const flash = require('express-flash')
const app = express()

const PORT = process.env.APP_PORT || 8080
const APP_NAME = process.env.APP_NAME || 'Express App'

// Express configs
app.set('view engine', 'ejs')
app.set('layout', 'layouts/layout')

// Middlewares
app.use(expressLayouts)
app.use(express.json())
app.use(express.urlencoded({ extended: true }))
app.use(express.static(path.join(__dirname, 'public')))
app.use(cors(['*']))
app.use(flash())
app.use(
	session({
		secret: process.env.APP_SESSION_SECRET || 'secret8080',
		resave: false,
		saveUninitialized: true,
		cookie: {
			maxAge: 1000 * 60 * 60 * 24, // day in milliseconds
		},
	})
)

// View Routes
app.use('/', require('./routes/index'))
app.use('/books', require('./routes/books'))

// API Routes
// app.use('/', require('./routes/api/auth'))

// Start express app
app.listen(PORT, () => {
	console.log(`${APP_NAME} listening on http://localhost:${PORT}`)
})
