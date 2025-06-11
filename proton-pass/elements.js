(()=>{"use strict";var t={13605:t=>{t.exports=function(t){var o=t[1],n=t[3];if(!n)return o;if("function"==typeof btoa){var A=btoa(unescape(encodeURIComponent(JSON.stringify(n))));return[o].concat(["/*# ".concat("sourceMappingURL=data:application/json;charset=utf-8;base64,".concat(A)," */")]).join(`
`)}return[o].join(`
`)}},63651:(t,o,n)=>{n.d(o,{A:()=>r});var A=n(13605),a=n.n(A),i=n(72485),e=n.n(i)()(a());e.push([t.id,":host{margin-left:unset;padding:0 !important;outline:none !important;outline-color:none !important;background-color:rgba(0,0,0,0) !important;border:none !important;box-shadow:none !important;min-width:unset !important;min-height:unset !important;overflow:unset !important;--frame-background-color-dark: #1f1f31;--frame-background-color-light: #fbf9fe;position:fixed !important;width:100% !important;border:0 !important;z-index:2147483647 !important;top:unset !important;right:unset !important;bottom:unset !important;left:unset !important;top:0 !important;left:0 !important;height:0 !important;padding:0 !important;margin:0 !important;--frame-background-color: var(--frame-background-color-dark)}:host([data-protonpass-theme=light]){--frame-background-color: var(--frame-background-color-light)}@media(prefers-color-scheme: light){:host([data-protonpass-theme=os]){--frame-background-color: var(--frame-background-color-light)}}:host::backdrop{position:fixed !important;top:0 !important;right:0 !important;bottom:0 !important;left:0 !important;background:rgba(0,0,0,0) !important;background-image:none !important;backdrop-filter:none !important;pointer-events:none !important;animation:none !important;transform:none !important;transition:none !important}iframe{position:absolute;width:var(--frame-width) !important;height:var(--frame-height) !important;top:var(--frame-top) !important;left:var(--frame-left) !important;right:var(--frame-right) !important;background-color:var(--frame-background-color) !important;box-shadow:0 2px 10px rgba(0,0,0,.3) !important;border-radius:12px !important;border:none !important;padding:0 !important;display:none;margin:0 !important;pointer-events:all !important}iframe.visible{display:block;transition:height .15s ease-in-out;animation:var(--frame-animation) .25s ease-in-out .05s both !important}iframe.fixed{position:fixed !important}@keyframes fadein{from{opacity:0;max-height:0}to{opacity:1;max-height:var(--frame-height)}}@keyframes slidein{from{transform:translateX(380px)}to{transform:translateX(0)}}","",{version:3,sources:["webpack://./src/app/content/injections/custom-elements/ProtonPassRoot.raw.scss","webpack://./src/app/content/injections/styles/reset.scss"],names:[],mappings:"AAEA,MCDC,iBAAA,CACA,oBAAA,CACA,uBAAA,CACA,6BAAA,CACA,yCAAA,CACA,sBAAA,CACA,0BAAA,CACA,0BAAA,CACA,2BAAA,CACA,yBAAA,CDLA,sCAAA,CACA,uCAAA,CAEA,yBAAA,CACA,qBAAA,CACA,mBAAA,CACA,6BAAA,CACA,oBAAA,CAAA,sBAAA,CAAA,uBAAA,CAAA,qBAAA,CACA,gBAAA,CACA,iBAAA,CACA,mBAAA,CACA,oBAAA,CACA,mBAAA,CAEA,4DAAA,CAGD,qCACC,6DAAA,CAIA,oCADD,kCAEE,6DAAA,CAAA,CAIF,gBACC,yBAAA,CACA,gBAAA,CAAA,kBAAA,CAAA,mBAAA,CAAA,iBAAA,CACA,mCAAA,CACA,gCAAA,CACA,+BAAA,CACA,8BAAA,CACA,yBAAA,CACA,yBAAA,CACA,0BAAA,CAGD,OACC,iBAAA,CACA,mCAAA,CACA,qCAAA,CACA,+BAAA,CACA,iCAAA,CAAA,mCAAA,CACA,yDAAA,CACA,+CAAA,CACA,6BAAA,CACA,sBAAA,CACA,oBAAA,CACA,YAAA,CACA,mBAAA,CACA,6BAAA,CAEA,eACC,aAAA,CACA,kCAAA,CACA,sEAAA,CAGD,aACC,yBAAA,CAIF,kBACC,KACC,SAAA,CACA,YAAA,CAGD,GACC,SAAA,CACA,8BAAA,CAAA,CAIF,mBACC,KACC,2BAAA,CAGD,GACC,uBAAA,CAAA",sourcesContent:[`@import '../styles/reset';

:host {
	@include reset;

	--frame-background-color-dark: #1f1f31;
	--frame-background-color-light: #fbf9fe;

	position: fixed !important;
	inline-size: 100% !important;
	border: 0 !important;
	z-index: 2147483647 !important;
	inset: unset !important;
	inset-block-start: 0 !important;
	inset-inline-start: 0 !important;
	block-size: 0 !important;
	padding: 0 !important;
	margin: 0 !important;

	--frame-background-color: var(--frame-background-color-dark);
}

:host([data-protonpass-theme='light']) {
	--frame-background-color: var(--frame-background-color-light);
}

:host([data-protonpass-theme='os']) {
	@media (prefers-color-scheme: light) {
		--frame-background-color: var(--frame-background-color-light);
	}
}

:host::backdrop {
	position: fixed !important;
	inset: 0 !important;
	background: transparent !important;
	background-image: none !important;
	backdrop-filter: none !important;
	pointer-events: none !important;
	animation: none !important;
	transform: none !important;
	transition: none !important;
}

iframe {
	position: absolute;
	inline-size: var(--frame-width) !important;
	block-size: var(--frame-height) !important;
	inset-block-start: var(--frame-top) !important;
	inset-inline: var(--frame-left) var(--frame-right) !important;
	background-color: var(--frame-background-color) !important;
	box-shadow: 0 2px 10px rgb(0 0 0 / 0.3) !important;
	border-radius: 12px !important;
	border: none !important;
	padding: 0 !important;
	display: none;
	margin: 0 !important;
	pointer-events: all !important;

	&.visible {
		display: block;
		transition: block-size 0.15s ease-in-out;
		animation: var(--frame-animation) 0.25s ease-in-out 0.05s both !important;
	}

	&.fixed {
		position: fixed !important;
	}
}

@keyframes fadein {
	from {
		opacity: 0;
		max-block-size: 0;
	}

	to {
		opacity: 1;
		max-block-size: var(--frame-height);
	}
}

@keyframes slidein {
	from {
		transform: translateX(380px);
	}

	to {
		transform: translateX(0);
	}
}
`,`@mixin reset {
	margin-inline-start: unset;
	padding: 0 !important;
	outline: none !important;
	outline-color: none !important;
	background-color: transparent !important;
	border: none !important;
	box-shadow: none !important;
	min-inline-size: unset !important;
	min-block-size: unset !important;
	overflow: unset !important;
}
`],sourceRoot:""}]);let r=e},72485:t=>{t.exports=function(t){var o=[];return o.toString=function(){return this.map(function(o){var n="",A=void 0!==o[5];return o[4]&&(n+="@supports (".concat(o[4],") {")),o[2]&&(n+="@media ".concat(o[2]," {")),A&&(n+="@layer".concat(o[5].length>0?" ".concat(o[5]):""," {")),n+=t(o),A&&(n+="}"),o[2]&&(n+="}"),o[4]&&(n+="}"),n}).join("")},o.i=function(t,n,A,a,i){"string"==typeof t&&(t=[[null,t,void 0]]);var e={};if(A)for(var r=0;r<this.length;r++){var s=this[r][0];null!=s&&(e[s]=!0)}for(var m=0;m<t.length;m++){var p=[].concat(t[m]);A&&e[p[0]]||(void 0!==i&&(void 0===p[5]||(p[1]="@layer".concat(p[5].length>0?" ".concat(p[5]):""," {").concat(p[1],"}")),p[5]=i),n&&(p[2]&&(p[1]="@media ".concat(p[2]," {").concat(p[1],"}")),p[2]=n),a&&(p[4]?(p[1]="@supports (".concat(p[4],") {").concat(p[1],"}"),p[4]=a):p[4]="".concat(a)),o.push(p))}},o}},90326:(t,o,n)=>{n.d(o,{A:()=>r});var A=n(13605),a=n.n(A),i=n(72485),e=n.n(i)()(a());e.push([t.id,":host{margin-left:unset;padding:0 !important;outline:none !important;outline-color:none !important;background-color:rgba(0,0,0,0) !important;border:none !important;box-shadow:none !important;min-width:unset !important;min-height:unset !important;overflow:unset !important;pointer-events:none;position:absolute !important;isolation:unset !important;margin:0 !important;opacity:1;z-index:unset !important;order:0 !important;height:0 !important;width:0 !important;float:left !important;animation:none !important;flex:0 0 0;grid-row:auto/span 1 !important;grid-column:auto/span 1 !important}:host>input{pointer-events:all}button{margin-left:unset;padding:0 !important;outline:none !important;outline-color:none !important;background-color:rgba(0,0,0,0) !important;border:none !important;box-shadow:none !important;min-width:unset !important;min-height:unset !important;overflow:unset !important;pointer-events:all;margin:auto;top:0;right:.3571428571em;opacity:.9;max-width:0;animation:icon-fade-in .25s ease-in-out .05s both !important;transition:opacity .2s ease-in-out;margin-top:0 !important;cursor:pointer !important;position:absolute !important;background-size:cover !important;border-radius:unset !important}button:hover,button:focus,button:active{transform:none !important}button::before{content:none !important}button::after{content:var(--control-count) !important;position:absolute !important;top:0 !important;right:0 !important;bottom:0 !important;left:0 !important;margin:auto !important;width:var(--control-lineheight) !important;color:#fff !important;text-align:center !important;font-family:system-ui,sans-serif !important;line-height:var(--control-lineheight) !important;font-size:var(--control-fontsize) !important;display:block !important;font-weight:bold !important;text-shadow:0 .5px 3px #320dc5 !important;opacity:0;animation:counter-fade-in .15s ease-in-out .15s both !important}button:hover{opacity:1}@keyframes icon-fade-in{from{opacity:0;max-width:0}to{opacity:.9;max-width:2.5em}}@keyframes counter-fade-in{from{opacity:0}to{opacity:1}}","",{version:3,sources:["webpack://./src/app/content/injections/custom-elements/ProtonPassControl.raw.scss","webpack://./src/app/content/injections/styles/reset.scss"],names:[],mappings:"AAMA,MCLC,iBAAA,CACA,oBAAA,CACA,uBAAA,CACA,6BAAA,CACA,yCAAA,CACA,sBAAA,CACA,0BAAA,CACA,0BAAA,CACA,2BAAA,CACA,yBAAA,CDDA,mBAAA,CACA,4BAAA,CACA,0BAAA,CAGA,mBAAA,CACA,SAAA,CACA,wBAAA,CACA,kBAAA,CACA,mBAAA,CACA,kBAAA,CAEA,qBAAA,CACA,yBAAA,CAGA,UAAA,CAGA,+BAAA,CACA,kCAAA,CAEA,YACC,kBAAA,CAIF,OCnCC,iBAAA,CACA,oBAAA,CACA,uBAAA,CACA,6BAAA,CACA,yCAAA,CACA,sBAAA,CACA,0BAAA,CACA,0BAAA,CACA,2BAAA,CACA,yBAAA,CD6BA,kBAAA,CACA,WAAA,CACA,KAAA,CACA,mBAAA,CACA,UAAA,CACA,WAAA,CACA,4DAAA,CACA,kCAAA,CACA,uBAAA,CACA,yBAAA,CACA,4BAAA,CACA,gCAAA,CACA,8BAAA,CAEA,wCAGC,yBAAA,CAGD,eACC,uBAAA,CAGD,cACC,uCAAA,CACA,4BAAA,CACA,gBAAA,CAAA,kBAAA,CAAA,mBAAA,CAAA,iBAAA,CACA,sBAAA,CACA,0CAAA,CACA,qBAAA,CACA,4BAAA,CACA,2CAAA,CACA,gDAAA,CACA,4CAAA,CACA,wBAAA,CACA,2BAAA,CACA,yCAAA,CACA,SAAA,CACA,+DAAA,CAGD,aACC,SAAA,CAIF,wBACC,KACC,SAAA,CACA,WAAA,CAGD,GACC,UAAA,CACA,eAAA,CAAA,CAIF,2BACC,KACC,SAAA,CAGD,GACC,SAAA,CAAA",sourcesContent:[`$base-font-size: 14 !default;

@use 'sass:meta';
@import '@proton/styles/scss/lib/em';
@import '../styles/reset';

:host {
	@include reset;

	pointer-events: none;
	position: absolute !important;
	isolation: unset !important;

	/* force reset element */
	margin: 0 !important;
	opacity: 1;
	z-index: unset !important;
	order: 0 !important;
	block-size: 0 !important;
	inline-size: 0 !important;
	/* stylelint-disable-next-line */
	float: left !important;
	animation: none !important;

	/* if parent display: flex */
	flex: 0 0 0;

	/* if parent display: grid */
	grid-row: auto / span 1 !important;
	grid-column: auto / span 1 !important;

	> input {
		pointer-events: all;
	}
}

button {
	@include reset;

	pointer-events: all;
	margin: auto;
	inset-block-start: 0;
	inset-inline-end: em(5);
	opacity: 0.9;
	max-inline-size: 0;
	animation: icon-fade-in 0.25s ease-in-out 0.05s both !important;
	transition: opacity 0.2s ease-in-out;
	margin-block-start: 0 !important;
	cursor: pointer !important;
	position: absolute !important;
	background-size: cover !important;
	border-radius: unset !important;

	&:hover,
	&:focus,
	&:active {
		transform: none !important;
	}

	&::before {
		content: none !important;
	}

	&::after {
		content: var(--control-count) !important;
		position: absolute !important;
		inset: 0 !important;
		margin: auto !important;
		inline-size: var(--control-lineheight) !important;
		color: white !important;
		text-align: center !important;
		font-family: system-ui, sans-serif !important;
		line-height: var(--control-lineheight) !important;
		font-size: var(--control-fontsize) !important;
		display: block !important;
		font-weight: bold !important;
		text-shadow: 0 0.5px 3px #320dc5 !important;
		opacity: 0;
		animation: counter-fade-in 0.15s ease-in-out 0.15s both !important;
	}

	&:hover {
		opacity: 1;
	}
}

@keyframes icon-fade-in {
	from {
		opacity: 0;
		max-inline-size: 0;
	}

	to {
		opacity: 0.9;
		max-inline-size: em(35);
	}
}

@keyframes counter-fade-in {
	from {
		opacity: 0;
	}

	to {
		opacity: 1;
	}
}
`,`@mixin reset {
	margin-inline-start: unset;
	padding: 0 !important;
	outline: none !important;
	outline-color: none !important;
	background-color: transparent !important;
	border: none !important;
	box-shadow: none !important;
	min-inline-size: unset !important;
	min-block-size: unset !important;
	overflow: unset !important;
}
`],sourceRoot:""}]);let r=e}},o={};function n(A){var a=o[A];if(void 0!==a)return a.exports;var i=o[A]={id:A,exports:{}};return t[A](i,i.exports,n),i.exports}n.n=t=>{var o=t&&t.__esModule?()=>t.default:()=>t;return n.d(o,{a:o}),o},n.d=(t,o)=>{for(var A in o)n.o(o,A)&&!n.o(t,A)&&Object.defineProperty(t,A,{enumerable:!0,get:o[A]})},n.o=(t,o)=>Object.prototype.hasOwnProperty.call(t,o);let A="data-protonpass-role",a=[A,"data-protonpass-theme","aria-hidden","popover"];class i extends HTMLElement{mutationObs=null;attrsMutationCount=new Map;constructor(t){super();let o=this.attachShadow({mode:"open"}),n=new CSSStyleSheet;n.replaceSync(t),o.adoptedStyleSheets.push(n)}connectedCallback(){this.mutationObs=new MutationObserver(t=>{for(let{type:o,attributeName:n}of t)if("attributes"===o&&n&&!a.includes(n)){let t=this.attrsMutationCount.get(n)??0;this.attrsMutationCount.set(n,t+1),this.removeAttribute(n),t>25&&(a.push(n),this.attrsMutationCount.delete(n))}}),this.mutationObs.observe(this,{attributes:!0,childList:!1})}disconnectedCallback(){this.mutationObs?.disconnect()}}var e=n(90326);class r extends i{static getTagName=t=>`protonpass-control-${t}`;constructor(){super(e.A)}connectedCallback(){super.connectedCallback(),this.setAttribute(A,"icon")}}var s=n(63651);class m extends i{static getTagName=t=>`protonpass-root-${t}`;constructor(){super(s.A)}disconnectedCallback(){super.disconnectedCallback(),requestIdleCallback(()=>{let t=new CustomEvent("PassRootRemoved",{bubbles:!0});this.dispatchEvent(t)})}connectedCallback(){super.connectedCallback(),this.setAttribute(A,"root")}}((t,o,n)=>globalThis.exportFunction?.(t,o,n)??(o[n.defineAs]=t))(t=>{let o=m.getTagName(t),n=r.getTagName(t);customElements.get(o)||customElements.define(o,m),customElements.get(n)||customElements.define(n,r),delete window.registerPassElements},window,{defineAs:"registerPassElements"})})();
