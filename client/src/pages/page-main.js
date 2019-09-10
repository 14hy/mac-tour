import { LitElement, html, css } from 'lit-element'

import i18next from 'i18next'

export class PageMain extends LitElement {
	static get styles() {        
		return css`
		:host {
			display: flex;
			position: absolute;
			top: 0;
			left: 0;
			width: 100vw;
			height: 100vh;
			margin: 0;
			padding: 0;
			justify-content: center;
			align-items: center;
		}
		`
	}

	static get properties() {
		return {
			title: String,
		}
	}
	
	constructor() {
		super()
		this.title = i18next.t(`APP_NAME`)
	}

	render() {
		return html`
		${this.title}
        `
	}
}

customElements.define(`page-main`, PageMain)
