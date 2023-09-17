<template>
  <section class="page pt-5">
    <!-- <DaterangepickerFormcontrol
      name="name"
      gravity="right"
      min?=""
      max=""
      cls?=""
      :editing="true"
      gap="10"
      errors=""
      label=""
      ,
    /> -->

    <list-top-companies ref="listTopCompaniesREF" />

    <list-new-companies ref="listNewCompaniesREF" />

    <list-top-tags ref="listTopTagsREF" />

    <div class="md:flex md:gap-x-5 mb-5">
      <bigCard class="md:w-8/12" />
      <most-clicked-business-carousal
        @more="listTopCompaniesREF.open()"
        class="md:w-4/12"
      />
    </div>

    <div class="md:flex justify-stretch gap-x-5 gap-y-10 mb-10">
      <total-new-business-card class="my-5 md:my-0" />
      <total-store-card class="my-5 md:my-0" />
      <total-users-card class="my-5 md:my-0" />
    </div>
    <!--  -->
    <div class="grid lg:grid-cols-3 grid-cols-1 mt-5 gap-x-5">
      <list-new-business @click="listNewCompaniesREF.open()" />

      <most-searched-tags @click="listTopTagsREF.open()" />

      <div class="">
        <how-many-online />
        <how-many-search-today />
      </div>

      <!-- <div class="">
        <div
          class="px-5 py-3 grid grid-cols-3 text-sm font-bold dark:bg-card-dark"
        >
          <p>Name</p>
          <p>Image</p>
          <p></p>
        </div>
        <div class=""></div>
      </div> -->
    </div>
    <!--  -->
  </section>
</template>

<script lang="ts" setup>
import totalNewBusinessCard from "./dashboard/total.new.business.card.vue";
import totalUsersCard from "./dashboard/total.users.card.vue";
import totalStoreCard from "./dashboard/total.stores.card.vue";
import ListNewBusiness from "./dashboard/list.new.business.vue";
import bigCard from "./dashboard/big.card.vue";
import mostClickedBusinessCarousal from "./dashboard/most.clicked.business.carousal.vue";
import HowManyOnline from "./dashboard/how.many.online.vue";
import HowManySearchToday from "./dashboard/how.many.search.today.vue";
import MostSearchedTags from "./dashboard/most.searched.tags.vue";
import ListTopCompanies from "./modals/list.top.companies.vue";
import ListNewCompanies from "./modals/list.new.companies.vue";
import ListTopTags from "./modals/list.top.tags.vue";
import { ref } from "vue";

let listTopCompaniesREF = ref<any>();
let listNewCompaniesREF = ref<any>();
let listTopTagsREF = ref<any>();
//
</script>
<style></style>
