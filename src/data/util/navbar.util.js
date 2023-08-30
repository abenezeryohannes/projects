
class NavbarUtil{
    
    calculateOpacity = (header) => {
        let scrollpos = window.scrollY;
        const header_height = header.offsetHeight;

        const add_class_on_scroll = () => header.classList.add("isActive");
        const remove_class_on_scroll = () => header.classList.remove("isActive");

        window.addEventListener("scroll", function () {
            scrollpos = window.scrollY;
            if (scrollpos >= header_height) {
                add_class_on_scroll();
            } else {
                remove_class_on_scroll();
            }
        });
    }
    
}

export default new NavbarUtil();
