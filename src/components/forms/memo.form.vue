<template>
    <section>


        <div class="flex flex-wrap gap-x-5 gap-y-5">
            <div class="" v-for="(memo, index) in memos_array" :key="index">
                <image-form :editable="false" :deletable="true" rounded='rounded-lg' @on-delete="onDelete(memo)"
                    :errors="null" :height="item_height" :editing="editing" :width="item_width" :padding="item_padding"
                    :link="memo.path" :local_image_file="getImageFile(memo, index)" />
            </div>
            <div v-if="editing">
                <image-form @on-change="onAdd($event[$event.length-1]);" rounded='rounded-lg' :errors="null"
                    :height="item_height" :editing="true" :width="item_width" :padding="item_padding"  />
            </div>
        </div>

    </section>
</template>

<script setup lang="ts">

import { onMounted, ref, watch } from 'vue';
import { useToast } from 'vue-toastification';
import errorHandlerUtil from '../../data/util/error.handler.util';
import Memo from '../../data/util/memo.util';
import { useI18n } from '../../i18n';

const { t } = useI18n();

const props = defineProps<{
    memos: any, errors?: any[], editing: boolean, item_width?: number,
    item_height?: number, item_padding?: number
}>();

const emit = defineEmits<{
    (event: 'on-change', params: any): void
}>();

const memos_array = ref<Memo[]>([]);
const new_memos = ref<Memo[]>([]);
const deleted_memos = ref<Memo[]>([]);

watch(() => props.memos, (val, old) => { memos_array.value = (val == null) ? [] : Memo.decode(val); });
watch(() => props.editing, (val, old) => { deleted_memos.value = []; new_memos.value = []; });

function getImageFile(memo: any, index: number) {
    if (memo.path != null) return null;
    else {
        var pos = (index - (memos_array.value.length - new_memos.value.length))
        var res = new_memos.value[pos];
        return res;
    }
}
function onchange() {
    const nm = new_memos.value.filter(x => { return x != null });
    const dm = deleted_memos.value.filter(x => { return x != null });
    const finalmemo = Memo.memfication(memos_array.value, nm, dm);
    console.log(finalmemo);
    // console.log('memos', finalmemo);
    // console.log('new_memos', nm);
    // console.log('deleted_memos', dm);
    emit('on-change', { new_memos: nm, deleted_memos: dm, memos: finalmemo });
}
function onDelete(memo: any) {
    // console.log('-- deleting --- ')
    // console.log(memo);
    // console.log('deletedmemos', deleted_memos.value);
    //add deleted memo to deleted memos if not present
    // if(Memo.includes(deleted_memos.value, memo)==-1)
    deleted_memos.value.push(memo);
    // console.log('after adding deleted memo ', deleted_memos.value);
    //remove the deleted memo from new memo if present
    const nm_index = Memo.includes(new_memos.value, memo);
    if (nm_index >= 0) new_memos.value.splice(nm_index, 1);
    //    console.log('-- deleting end ---')
    onchange();
}
function onAdd(memo: Memo) {
    // console.log('----- not working ----');
    // this.memos_array.forEach(element => {
    // console.log(element);

    // });
    // console.log('----- not working 2----');

    // console.log(memo);
    if (Memo.includes(memos_array.value, memo) != -1) {
        errorHandlerUtil.showError(t('duplicate_memo_upload'), useToast());
        return;
    }

    //add new memo to new memos if not present
    if (Memo.includes(new_memos.value, (memo)) == -1) new_memos.value.push(memo);

    //remove the new memo from deleted memo if present
    const dm_index = Memo.includes(deleted_memos.value, memo);
    if (dm_index != -1) deleted_memos.value.splice(dm_index, 1);

    onchange();
}

onMounted(() => { if (props.memos != null) memos_array.value = Memo.decode(props.memos); })

</script>

<style>

</style>