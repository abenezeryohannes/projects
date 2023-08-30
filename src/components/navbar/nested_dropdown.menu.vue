<template>
    <div ref="root" class="flex flex-col select-none">
        <div class="flex items-center justify-center">
            <div v-if="title" class="flex items-center text-lg font-bold justify-between cursor-pointer "
                :class="'h-' + height" @click.prevent="toggleShow">
                {{ title }}
                <svg xmlns="http://www.w3.org/2000/svg" class="ml-3 transition duration-150 ease-in-out"
                    :class="{ 'rotate-90': showMenu }" width="24" height="24" viewBox="0 0 20 20" fill="currentColor">
                    <path fill-rule="evenodd"
                        d="M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z"
                        clip-rule="evenodd" />
                </svg>
            </div>
            <div v-if='svg' @click.prevent="toggleShow">
                <icon-wrapper class="text-center m-auto" :size="height" :svg='svg' :padding=0 />
            </div>
        </div>

        <div class="absolute z-30 right-0 bg-background-light top-12 dark:bg-background-deepdark py-1 shadow transition duration-150 ease-in-out"
            :class="[{ 'hidden': !showMenu }, dropdown_top_margin]">
            <div v-show="menu_items != current_menu.children" class="  flex flex-row mx-3 text-center mb-3 ml-3 pr-14">
                <div @click="onBackClicked" class="text-center">
                    <!-- <icon-wrapper  svg="arrow-right" :size=8 padding="1" class="my-auto" /> -->
                    <v-icon icon="arrow-left" :size=8 fill="background-dark" class="my-auto pt-1" cls="dark:text-white"
                        @click="onBackClicked" />
                </div>
                <p class="text-left text-sm font-semibold ml-2 my-auto capitalize"> {{ t(String(current_menu?.name)) }}
                </p>
            </div>
            <ul v-for="(item) in current_menu.children" :key='item.name + item.description'>
                <li class="flex flex-row py-2 px-3 cursor-pointer dark:hover:bg-opacity-50 dark:hover:bg-background-darkish
                       hover:bg-background-lightish " @click="goTo(current_menu, item)">
                    <icon-wrapper v-if="item.image" :link="store.getters.user.avatar" :padding=0 :size=6
                        class="my-auto" />
                    <icon-wrapper v-if="item.svg" :svg="item.svg" :padding=1 class="my-auto" :size=6 />
                    <div class=" flex flex-col mx-3 my-auto">
                        <p class="text-left text-xs font-semibold capitalize"> {{ (item.name != null) ?
                                t(item.name.toLowerCase()) : null
                        }}</p>
                        <p class="text-xs "> {{ (item.description != null) ? t(item.description.toLowerCase()) : null
                        }}
                        </p>
                    </div>

                    <div v-if="item.children != null && item.children.length > 0" class="ml-16 my-auto text-center">
                        <v-icon icon="arrow-right" :size=6 fill="background-dark" cls="dark:text-white" />
                    </div>
                </li>
            </ul>
        </div>
    </div>
</template>

<script setup lang="ts">
import { computed } from 'vue';
import { onBeforeUnmount, onMounted, ref } from 'vue';
import { useRouter } from 'vue-router';
import { useI18n } from '../../i18n';
import { useStore } from '../../store';
import iconWrapper from '../common/icon.wrapper.vue';
import VIcon from '../icons/v-icon.vue';

const router = useRouter();
const store = useStore();
const { t } = useI18n();

const props = withDefaults(defineProps<{
    title?: string, height?: number, svg?: string, padding?: number,
}>(), {
    height: 8, padding: 2
});

let root = ref<any>(null);
let showMenu = ref<boolean>(false);
let menu_items = ref<any>([]);
let current_menu = ref<any>({ children: null });
let close_menu_when_clicked = ref<boolean>(true);

const dropdown_top_margin = computed(() => {
    return showMenu.value ? "mt-" + (props.height + 4) : 'mt-0';
});

function toggleShow() {
    // console.log(current_menu.value);
    showMenu.value = !showMenu.value;
}

function close(e: any) {
    if (!root.value?.contains(e.target) && close_menu_when_clicked.value) {
        showMenu.value = false; showRootItems();
    }
    if (!close_menu_when_clicked.value) close_menu_when_clicked.value = true;
}

async function goTo(current_menu: any, x: any) {
    console.log(current_menu, x);
    if (x.children != null && x.children.length > 0) {
        current_menu.value = x;
        close_menu_when_clicked.value = false;
    } else {
        switch (x.name) {
            case "my_profile":
                if (router.currentRoute.value.name != 'profile')
                    router.push({ name: 'profile' });
                break;
            case "users":
                if (router.currentRoute.value.name != 'users')
                    router.push({ name: 'users' });
                break;
            case 'log_out':
                await store.dispatch('signOut');
                break;
        }
        showMenu.value = false;
    }
    // console.log(x.name);
}

function onBackClicked() {
    showRootItems();
}

function showRootItems() {
    current_menu.value = { children: menu_items.value };
}

onMounted(() => {
    menu_items.value = [
        {
            name: "users", description: "manage_users", image: null, svg: 'users', route: '',
            children: null
        },
        {
            name: "log_out", description: "log_out_from_this_ computer", image: null, svg: 'sign-out', route: '',
            children: null
        }
    ];
    showRootItems();

    document.addEventListener('click', close)
});

onBeforeUnmount(() => {
    showRootItems();
    document.removeEventListener('click', close)
});

</script>

<style>
.dropdown-menu {
    transition: 300ms;
}

svg.rotate-90 {
    transform: rotate(90deg);
}
</style>