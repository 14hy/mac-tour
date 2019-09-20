import { html, render } from 'lit-html'
import i18next from 'i18next'

export class regionSelector extends HTMLElement {
	constructor() {
		super()
	}

	connectedCallback() {
		render(this.render(), this)		
	}

	render() {
		return html`
		${style}
		TEST
        `
	}
}

const style = html`
<style>

</style>
`

customElements.define(`region-selector`, regionSelector)
