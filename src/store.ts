import { InjectionKey } from "vue";
import Page from "./domain/page";
import { Store, createStore, useStore as baseUseStore } from "vuex";
import { VuexPersistence } from "vuex-persist";
import { User } from "./domain/user/entity/user.entity";
import { Token } from "./domain/user/entity/token.entity";

// define your typings for the store state
export interface State {
  user: User | null;
  token: Token | null;
  pages: Page[] | [] | null;
}

// define injection key
export const key: InjectionKey<Store<State>> = Symbol();

export const store = createStore<State>({
  state: { user: null, token: null, pages: [] },
  mutations: {
    setUser(state, data) {
      state.user = data == null ? null : new User(data);
    },
    setToken(state, data) {
      localStorage.setItem("token", data.token);
      state.token = data == null ? null : new Token(data);
    },
    loadPages(state, data) {
      localStorage.setItem("pages", data.pages);
      state.pages = data == null ? [] : data.map((x: any) => new Page(x));
    },
  },
  getters: {
    user: (state) => {
      return state.user == null ? null : state.user;
    },
    token: (state) => {
      return state.user == null ? null : state.token;
    },
    pages: (state) => {
      return state.pages == null ? [] : state.pages;
    },
  },
  actions: {
    signOut({ commit }) {
      commit("setUser", null);
      commit("setToken", null);
    },
    signIn({ commit }, user: User) {
      commit("setUser", user);
      if (user.tokens != null && user.tokens.length > 0)
        commit("setToken", user?.tokens[0]);
    },
    loadPages({ commit }, pages: Page[]) {
      commit("loadPages", pages);
    },
  },
  plugins: [new VuexPersistence({ storage: window.localStorage }).plugin],
});

// define your own `useStore` composition function
export function useStore() {
  return baseUseStore(key);
}
