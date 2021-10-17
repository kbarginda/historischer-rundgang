let openSideBar = false;
	
function getinfo(page) {
    if (openSideBar) {
        infoCloseAll();
    }
    openInfo(page);
}

function openInfo(page) {
    document.getElementById(page).style.width = "300px";
    document.getElementById(page).style.paddingLeft = "29px";
    openSideBar = true;
}

function infoCloseAll() {
    let pages = document.getElementsByClassName('subsidebar');
    for(let page of pages) {
      page.style.width = "0";
      page.style.paddingLeft = "0";
    }
    openSideBar = false;
}