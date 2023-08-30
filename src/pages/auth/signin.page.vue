<template>
  <section>
    <div
      class="select-none flex items-center justify-center bg-background-lightish dark:bg-background-dark text-gray-700 dark:text-white h-screen lg:w-10/12 md:w-10/12 w-full mx-0 md:mx-auto"
    >
      <!-- <div class="h-24 bg-red-700" /> -->

      <div
        class="flex rounded-xl shadow-xl mb-10 bg-background-light dark:bg-background-dark lg:h-4/6 sm:mx-24 md:mx-0"
      >
        <div class="lg:w-6/12 md:w-8/12 w-0">
          <img
            class="w-full h-full rounded-l-xl object-cover"
            src="landing.png"
          />
        </div>

        <div class="flex-grow pt-24 justify-center lg:px-12 px-8">
          <div class="">
            <p class="text-center font-bold text-2xl">Linko AI</p>
          </div>

          <div class="mt-5 mb-10">
            <p class="text-center font-semibold text-sm px-10">
              Simple AI service for the field of commerce and e-commerce sites.
            </p>
          </div>

          <form>
            <div class="mt-5">
              <label class="block text-left px-10">
                <span class="text-xs font-semibold my-2">Phone Number</span>
                <div class="mt-3">
                  <input
                    type="phone"
                    v-model.trim.lazy="email"
                    class="form-control focus:outline-none rounded-xl shadow mt-1 block w-full px-2 py-2 bg-background-lightish dark:bg-background-darkish"
                  />
                </div>
              </label>

              <label class="block text-left text-sm px-10 mb-5 mt-5">
                <span class="font-semibold my-2 text-xs">Password</span>
                <div class="relative mt-3">
                  <input
                    :type="showPassword ? 'text' : 'password'"
                    v-model.lazy="password"
                    class="focus:outline-none rounded-xl shadow mt-1 block w-full px-2 py-2 bg-background-lightish dark:bg-background-darkish"
                  />
                  <div
                    @click="showPassword = !showPassword"
                    class="absolute cursor-pointer inset-y-0 right-0 pr-3 mt-1 flex items-center text-sm leading-5"
                  >
                    <v-icon
                      v-show="showPassword"
                      icon="eye-open"
                      fill="gray-700"
                      :size="5"
                    />
                    <v-icon
                      v-show="!showPassword"
                      icon="eye-closed"
                      fill="gray-400"
                      :size="5"
                    />
                  </div>
                </div>
              </label>
            </div>
          </form>

          <div
            class="error text-sm text-red-600 text-center font-semibold px-12 my-3"
            v-if="server_error_response != null"
          >
            {{ server_error_response }}
          </div>

          <div class="block px-10 pt-16 pb-16">
            <button
              class="focus:outline-none rounded-lg py-2 text-center text-white text-lg font-bold shadow-lg bg-accent-light dark:bg-accent w-full"
              @click="login"
            >
              Login
            </button>
          </div>
        </div>
      </div>
      <div class="h-24" />
    </div>
  </section>
</template>

<script setup lang="ts">
import vIcon from "../../components/icons/v-icon.vue";
import RH from "../../data/util/request.handler";
import { useStore } from "../../store";
import { useRouter } from "vue-router";
import { ref } from "vue";
import { useToast } from "vue-toastification";
import errorHandlerUtil from "../../data/util/error.handler.util";
const showPassword = ref<boolean>(false);
const email = ref<string>("");
const password = ref<string>("");
const store = useStore();
const toast = useToast();
const router = useRouter();

const server_error_response = ref<any>(null);

// const user = computed(() => useStore().getters.user)

async function login() {
  server_error_response.value = null;
  try {
    let response = await new RH().post("auth/login", {
      phoneNumber: email.value,
      role: "ADMIN",
      UID: password.value,
    });
    //console.log("response: ", response);
    if (response.data.success) {
      //console.log("server response", response.data.data);
      await store.dispatch("signIn", response.data.data);
      // console.log('vuex result saved:', user);
    } else {
      console.log("server failed", response.data);
      errorHandlerUtil.showError(response.data.message, useToast());
    }
    // console.log(response);
    router.push({ path: "/" });
  } catch (e: any) {
    // console.log('this is error ', e.toString())
    server_error_response.value = errorHandlerUtil.handle(e, toast, router);
  }
}
</script>

<style></style>
