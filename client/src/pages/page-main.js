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
		<div id="pageMain" class="page" data-name="home">
			<header>				
				<div class="logo">Logo</div>
				<div class="title">Title</div>
			</header>
			<main>
				<div class="content">컨텐츠</div>
				<div class="content">컨텐츠</div>
				<div class="content">컨텐츠</div>
				<div class="content">컨텐츠</div>
				<div class="content">컨텐츠</div>
				<div class="content">컨텐츠</div>
				<div class="content">컨텐츠</div>
			</main>
		</div>
        `
	}
}

const style = html`
<style>
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

header {
    display: grid;
    grid-template-columns: 100px auto;
    grid-template-rows: 50px;  
    border-bottom: 1px solid #595959;
}

main {
    overflow: scroll;
}

.content {
    height: 150px;
}

.logo, .title, .select-local, .my-local, footer span, .content, .search {
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
