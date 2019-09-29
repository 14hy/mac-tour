import store from './store'

function actionCreator(action) {
	return function() {
		let state = store.getState()
		state = action(state, ...arguments)
		store.setState(state)
	}
}

// ===================================================== Code Structure

export const countAdd = actionCreator(state => {
	state.info.count === undefined
		? state.info.count = 0
		: state.info.count++
	return state
})

// ===================================================== Router

export const loadXhr = obj => new Promise((resolve, reject) => {
	const req = new XMLHttpRequest()

	if (!req) {
		throw new Error(`No exist XHR`)
	}

	req.open(obj.method, obj.url)	

	req.setRequestHeader(`x-requested-with`, `XMLHttpRequest`)
	req.onreadystatechange = () => {
		if (req.readyState === XMLHttpRequest.DONE) {
			if (req.status === 200 || req.status === 201) {
				resolve(req.responseText)			
			} else {
				reject(req.statusText)
			}
		}
	}
	req.send(obj.body || null)
})
