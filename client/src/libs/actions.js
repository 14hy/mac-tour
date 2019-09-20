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

export const getXhr = actionCreator((state, url, callback) => {
	const xhr = new XMLHttpRequest()

	if(!xhr) {
		throw new Error(`XHR 호출 불가`)
	}

	xhr.open(`GET`, url)
	xhr.setRequestHeader(`x-requested-with`, `XMLHttpRequest`)
	xhr.addEventListener(`readystatechange`, () => {
		if (xhr.readyState === xhr.DONE) {				
			if (xhr.status === 200 || xhr.status === 201) {
				callback(xhr.responseText)
			}
		}
	})
	xhr.send()
	return state
})
