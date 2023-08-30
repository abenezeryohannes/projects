<template>
    <section>
        <div v-if="selecting"
            class="px-5 mb-3 shadow-lg py-1 flex  bg-primaryDark-light dark:bg-primaryDark-dark rounded-md">
            <p class="mr-6 my-auto text-white"> {{ t('items_selected', { var: selected.length }) }} </p>
            <div class="h-10 pt-1">
                <dropdown-form :value="bulkAction == null ? null : bulkAction.name" :editing="true" :error="null" :height=8
                    @on-change="bulkAction = $event; emit('bulk-select-action', $event)" :options="bulkActions"
                    name="action" placeholder="bulk actions" />
            </div>
            <div class="font-bold flex ml-5">
                <p class="mr-3 my-auto cursor-pointer text-white"
                    :class="[{ 'dark:text-gray-300 text-gray-400': bulkAction == null }]"
                    @click="emit('bulk-action', bulkAction)"> {{ t('confirm') }} </p>
                <p class="my-auto cursor-pointer text-white" @click="emit('bulk-action', { name: 'cancel' })">
                    {{ t('cancel') }} </p>
            </div>
        </div>
    </section>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { useI18n } from '../../../i18n';
import DropdownForm from '../../forms/dropdown.form.vue';

const props = defineProps<{
    headers: any,
    bulkActions: any,
    selected?: any,
    selecting?: any,
    checkAll?: any,
}>();
const bulkAction = ref<any>(null);

const { t } = useI18n();

const emit = defineEmits<{
    (event: 'bulk-action', param: any): void;
    (event: 'bulk-select-action', param: any): void;
}>();

</script>

<style>

</style>