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
        <ul>
            <li>
                <a class="item-link smart-select smart-select-init" data-open-in="popover">
                    <select name="region">
                        <option value="Batman" selected>Batman</option>
                        <option value="Superman">Superman</option>
                        <option value="Hulk">Hulk</option>
                        <option value="Spiderman">Spiderman</option>
                        <option value="Ironman">Ironman</option>
                        <option value="Thor">Thor</option>
                        <option value="Wonder Woman">Wonder Woman</option>
                    </select>

                    <div class="item-content">
                        <div class="item-inner">
                            <div class="item-title">${i18next.t(`REGION_ALL`)}</div>
                        </div>
                    </div>
                </a>
            </li>
        </ul>
        `
	}
}

const style = html`
<style>

</style>
`

customElements.define(`region-selector`, regionSelector)
