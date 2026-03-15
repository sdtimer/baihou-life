const storage = require("../utils/storage");

const defaultUser = {
  uid: null,
  role: 0,
  nickname: "",
  avatar_url: "",
  phone: "",
  region_id: "foshan"
};

let state = {
  token: "",
  profile: { ...defaultUser }
};

function bootstrap() {
  state.token = storage.get("token", "");
  state.profile = storage.get("user", { ...defaultUser });
}

function setAuth(payload) {
  state.token = payload.token || "";
  state.profile = {
    ...defaultUser,
    ...(payload.user || {})
  };
  storage.set("token", state.token);
  storage.set("user", state.profile);
}

function logout() {
  state.token = "";
  state.profile = { ...defaultUser };
  storage.remove("token");
  storage.remove("user");
}

function getState() {
  return state;
}

function isLoggedIn() {
  return Boolean(state.token);
}

function isDesigner() {
  return state.profile.role === 2;
}

module.exports = {
  bootstrap,
  setAuth,
  logout,
  getState,
  isLoggedIn,
  isDesigner
};
