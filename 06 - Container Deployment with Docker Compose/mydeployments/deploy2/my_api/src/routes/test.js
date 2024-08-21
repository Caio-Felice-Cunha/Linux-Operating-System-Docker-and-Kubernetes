// Constants
const express = require('express');
const router = express.Router();

// Get method
router.get('/', async (req, res) => {
	res.status(200).json({
		result: 'Success! The API works!'
	})
});

// Export
module.exports = router;