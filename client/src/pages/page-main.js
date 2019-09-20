import { html, render } from 'lit-html'
// import i18next from 'i18next'

export class PageMain extends HTMLElement {
	constructor() {
		super()
	}

	connectedCallback() {
		render(this.render(), this)		
	}

	render() {
		return html`
		${style}
		<div id="pageMain" class="page-content">
            <header>				
                TITLE
            </header>
            <main>
                <div class="content" @click="${this.clickContent}">컨텐츠</div>
            </main>
		</div>
        `
	}
    
	get clickContent() {
		return {
			handleEvent() {				
				window.mainView.router.navigate(`/detail/`)
			},
			capture: true,
		}
	}
}

const style = html`
<style>
page-main {
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
    overflow: hidden;    
}

#pageMain {
    border: 1px solid #595959;
    width: 100vw;
    height: 100vh;
    margin: 0 auto;
    padding: 0;
    border-radius: 2px;    

    display: grid;
    grid-template-rows: 50px auto;
}

page-main header {
    display: flex;
    justify-content: center;
    align-items: center;
}

page-main main {
    overflow: scroll;
}

page-main .content {
    height: 150px;
    cursor: pointer;
}

page-main .logo, page-main .title, page-main .select-local, page-main .my-local, page-main footer span, page-main .content, page-main .search {
    background-color: #EEEEEE;
    margin: 5px;
    border-radius: 3px;
    color: #999999;
    display: flex;
    justify-content: center;
    align-items: center;
}
</style>
`

customElements.define(`page-main`, PageMain)
