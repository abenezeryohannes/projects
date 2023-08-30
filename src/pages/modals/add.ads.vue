<template>
    <modal class=" w-3/4" ref="Modal" :show="show" @on-show="show = $event">

        <template v-slot:header>
            <p class="text-xl font-bold text-left capitalize "> {{ t('New Feature') }} </p>
        </template>

        <section class="">
            
            <div class=" ">
                <add-ads-forms 
                :editing="editing" :loading="loading" :errors="errors"
                :temp_ad="temp_ad" 
                @on-change="temp_ad = $event;" 
                @on-icon-change="banner = $event;" 
                />
            </div>

            <edit-fab class="fixed right-0 mr-5 bottom-5 " :editing="editing" :errors="errors" 
                :loading="loading" @edit="edit" @save="save" @cancel="cancel" />
        
        </section>
    </modal>
</template>
   
<script setup lang="ts">
 
import addAdsForms from '../forms/add.ads.forms.vue';
import EditFab from '../../components/common/edit.fab.vue'
import modal from '../../components/common/modal.vue'
import { ref } from 'vue'
import errorHandlerUtil from '../../data/util/error.handler.util';
import { useRoute, useRouter } from 'vue-router';
import { useToast } from 'vue-toastification';
import RequestHandler from '../../data/util/request.handler';
import { useI18n } from '../../i18n';

const { t } = useI18n();

const route = useRoute();
const editing = ref<boolean>(false);
const loading = ref<boolean>(false);
const errors = ref<any>(null);
const temp_ad = ref<any>({ enabled: true });
const Modal = ref<any>(null);
const show = ref<boolean>(false);
const banner = ref<any>();
const router = useRouter();
const toast = useToast();


const emit = defineEmits<{
    (event: 'on-change'): void
}>();

defineExpose({
    open,
});

// function created() { window.addEventListener('scroll', handleScroll); }
// function destroyed() { window.removeEventListener('scroll', handleScroll); }
function edit() {
    editing.value = true;
    loading.value = false;
}

function cancel() {
    editing.value = false;
    loading.value = false;
    errors.value = null;
    close();
}

function close() {
    Modal.value?.close();
}

function open() {
    editing.value = true;
    Modal.value?.open();
}

async function save() {
    try {
        loading.value = true;
        var response = await (new RequestHandler()).postForm('ads/store', temp_ad.value, [
            { name: 'banner', file: banner.value }
        ]);
        console.log(response.status); 
        emit('on-change');
        close();
    } catch (e) { errorHandlerUtil.handle(e, toast, router); }
    finally { loading.value = false; }
}

async function load() {
    try {
        loading.value = true;
        var response = await new RequestHandler().get('ads/findAllForAdmin' + route.params.id, {});
        //console.log('load', response);
    } catch (e) { errorHandlerUtil.handle(e,  toast, router); }
    finally { loading.value = false; }
}

</script>
   
<style>

</style>