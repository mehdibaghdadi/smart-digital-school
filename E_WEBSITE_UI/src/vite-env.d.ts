/// <reference types="vite/client" />

interface ImportMetaEnv {
  readonly VITE_CONTACT_API_URL: string
  readonly VITE_VIDEO_URL_FR: string
  readonly VITE_VIDEO_URL_EN: string
  readonly VITE_VIDEO_URL_ES: string
}

interface ImportMeta {
  readonly env: ImportMetaEnv
}
