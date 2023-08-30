<template>
    <section>

        <div class="w-full text-xs">

            <div v-if="view == 'table'">
                <my-table @on-select="onSelect" @on-action="onAction" @on-page-change="emit('on-page-change', $event)"
                    @bulk-action="onBulkAction" @on-limit-change="emit('on-limit-change', $event)"
                    @on-sort-change="emit('on-sort-change', $event)" @on-item-click="emit('on-item-click', $event)"
                    :clickable="clickable" :loading="loading" :response="response" :list="tableData" :errors="errors"
                    :bulkActions="bulkActions" :headers="headers"   />
            </div>
            <div v-else>
                <grid @on-select="onSelect" @on-action="onAction" @on-page-change="emit('on-page-change', $event)"
                    @bulk-action="onBulkAction" @on-limit-change="emit('on-limit-change', $event)"
                    @on-item-click="emit('on-item-click', $event)" item="court" :clickable="clickable"
                    :loading="loading" :response="response" :list="gridData" :errors="errors"
                    :bulkActions="bulkActions" />
            </div>
        </div>

    </section>
</template>
  
<script setup lang="ts">

import Grid from '../../components/common/grid/grid.vue';
import { ref, watch } from 'vue';
import { useRouter } from 'vue-router';
import { useToast } from 'vue-toastification';
import myTable from '../../components/common/table/table.vue';
import errorHandlerUtil from '../../data/util/error.handler.util';
import RequestHandler from '../../data/util/request.handler';
import { useI18n } from '../../i18n';

const props = defineProps<{ list: any[], response?: any, view?: string | null, loading?: boolean, clickable?: boolean }>();
const { t } = useI18n();

const bulkActions = ref<any>([
    {
    name: 'Delete All', url: "posts/deleteAll", title: 'Are you sure?',
    description: 'This will delete all the selected posts.' 
}
]);

const headers = ref<any[]>([
                {name: '#bulk#', width:'1', sortable: false},
                {label:'description', name:'desc', width:'3', sortable:true, type:"text", editable: true, cls: 'justify-start'}, 
                {label:'user', name:'user', width:'2', sortable:false, type:"text", cls: 'justify-start', editable: true}, 
                {label:'group', name:'postGroup', width:'2', sortable:true, type:"dropdown", link: 'postGroups',
                //  type:"toggle",option:{positive: 'indoor', negative: 'outdoor'},
                 editable: true,cls: 'justify-start'}, 
                {label:'offer', name:'offer', width:'2', sortable:false, type:"toggle", option:{positive: 'offered', negative: 'wanted'}, cls: 'justify-start', editable: false}, 
                // {label:'whatsApp/Phone', name:'whatsAppAndPhone', width:'2', sortable:true, type:"text", editable: true, cls:'justify-start'}, 
                // {label:'Phone Number', name:'phoneNumber', width:'2', sortable:true, cls:'justify-center text-center', type:"text", editable:true}, 
                {label:'Featured', name:'featured', width:'2', sortable:true, cls:'justify-center text-center', type:"toggle",option:{positive: 'Yes', negative: 'No'} }, 
                {label:'Price', name:'price', width:'2', sortable:true, cls:'justify-center text-center', type:"cash", editable:true }, 
                {label:'action', name:'#actions#', width:'1', sortable:false, actions:['edit', 'delete']}, 
            ]);

const tableData = ref<any[]>([]);
const gridData = ref<any[]>([]);
const errors = ref<any[]>([]);
const search = ref<string | null>(null);
const sort_by = ref<string | null>(null);
const sort = ref<string | null>(null);

watch(() => props.list, (newValue, old) => { map(newValue); errors.value = []; });
watch(() => props.view, (nw, ol) => { map(props.list); errors.value = []; });
const emit = defineEmits<{
    (event: 'update-list'): void
    (event: 'on-sort-change', param: any): void
    (event: 'on-page-change', param: any): void
    (event: 'on-item-click', param: any): void
    (event: 'on-limit-change', param: any): void
}>();
async function onBulkAction(x: { selected: any, action: any }) {

    console.log('on-bulk-action', x.selected, x.action, 'on-bulk-action-end')
    let ids: any[] = [];
    (x.selected as any[]).forEach(element => { ids.push(element.id); });
    try { 
        let response = await new RequestHandler().postForm(x.action.url, { 'ids': JSON.stringify(ids) }, []); 
        console.log(response);
        emit('update-list');
    } catch (e: any) {
        console.log(e.toString());
        errorHandlerUtil.handle(e, useToast(), useRouter());
    }
}
async function onAction(x: { index: number, body: any, action: string }) {
    console.log('on-action', x.index, x.body, x.action, 'on-action-end');
    if (props.list == null) return;

    switch (x.action.toLowerCase()) {
        case 'delete': 
            try {
                await new RequestHandler().post('employee/contracts/delete', { 'id': props.list![x.index].id });
                emit('update-list');
            } catch (e) {
                errorHandlerUtil.handle(e, useToast(), useRouter());
            }
            break;
        case 'edit': 
            try {
                console.log('request', x.body);
                var response = await new RequestHandler().postForm('employee/contracts/update/' + props.list![x.index].id,
                    x.body, [])
                console.log('request successfull', response.data);
                emit('update-list');
            } catch (e) {
                errorHandlerUtil.handle(e, useToast(), useRouter()); 
                errors.value[x.index] = {
                    index: x.index,
                    errors: errorHandlerUtil.handle(e, useToast(), useRouter()), body: x.body
                }; 
            }
            break;
        case 'cancel':
            errors.value.splice(x.index, 1);
            break
    }
}
function onSelect(selected: any) {
    console.log("on-select", selected, 'on-select-end')
}

function mapTableData(listPar: any[]) {
    tableData.value = [];
    listPar.forEach((element) => {
        const status = element.approved? (element.enabled?'active':'in-active'):'waiting-approval'
        tableData.value[tableData.value.length] = {
          userId: element.userId,
          user: element.User.fullName,
          desc: element.desc,
          whatsApp: element.whatsApp,
          phoneNumber: element.phoneNumber,
          featured: element.featured,
          offer: element.offer,
          postGroupId: element.postGroupId,
          postGroup: element.PostGroup.name,
          whatsAppAndPhone: element.whatsApp + ' ' + element.phoneNumber,
          price: String(element.price),
          enabled: element.enabled,
            status_cls: [
                { 'capitalize text-white bg-warning-light rounded-2xl shadow-xl px-2 py-1 ': status == 'waiting-approval' },
                // { 'capitalize text-white bg-error-light rounded-2xl shadow-xl px-2 py-1 ': status == 'defaulted' },
                { 'capitalize text-white bg-red-500 rounded-2xl shadow-xl px-2 py-1 ': status == 'in-active' },
                // { 'capitalize text-white bg-gray-700 rounded-2xl shadow-xl px-2 py-1 ': status == 'ended' },
                { 'capitalize text-white bg-success-light rounded-2xl shadow-xl px-3 py-1 ': status == 'active' }
            ]
        };
    });
}

function mapGridData(listPar: any[]) {
    gridData.value = [];
    listPar.forEach((element) => {
        gridData.value[gridData.value.length] = {
          userId: element.userId,
          user: element.User.fullName,
          desc: element.desc,
          whatsApp: element.whatsApp,
          phoneNumber: element.phoneNumber,
          featured: element.featured,
          offer: element.offer,
          postGroupId: element.postGroupId,
          postGroup: element.PostGroup.name,
          price: String(element.price),
          enabled: element.enabled,
        };
    });
}

function map(newValue: any) { (props.view == 'table') ? mapTableData(newValue) : mapGridData(newValue); } 

</script>
  
<style>

</style>