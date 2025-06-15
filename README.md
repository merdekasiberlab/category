# category

**category** adalah aplikasi Windows “satu-klik” yang secara otomatis mengelompokkan file di folder Downloads Anda ke dalam sub-folder berdasarkan kategori dan ekstensi—tanpa perlu hak admin atau konfigurasi rumit.

> 🔒 **100% kode aman**: semua skrip bersifat open-source, tanpa backdoor atau malware.

---

## 📦 Asset

- `category.exe` — Installer EXE satu-klik (tanpa perlu hak admin)

---

## ✨ Fitur Utama

- ✅ **Instalasi sekali klik**  
  Jalankan `category.exe` sekali, sistem akan membuat folder instalasi dan shortcut di Startup secara otomatis.

- 🔁 **Aktif setelah login**  
  Proses pemantauan berjalan di latar belakang setiap kali Anda **sign out & sign in** atau **restart** Windows.

- 🗂️ **Pengelompokan dua tingkat**  
  - **Level 1:** Kategori umum (Documents, Images, Audio, Video, dll.)  
  - **Level 2:** Sub-folder berdasarkan ekstensi (misal: `Downloads\Documents\docx\`)

- 🧠 **Ringan & tanpa service**  
  Tidak menjalankan service tambahan, hanya proses biasa, minim resource.

---

## 🚀 Cara Penggunaan

1. Download `category.exe` dari halaman [Releases](../../releases)  
2. Double-klik `category.exe` untuk menginstal  
3. Restart atau sign-out lalu login kembali ke Windows  
4. Coba download file apa saja (contoh: gambar atau dokumen)  
5. File Anda akan otomatis dipindahkan ke:  
   ```
   Downloads\<Kategori>\<Ekstensi>\
   ```

---

## ⚙️ Kustomisasi Kategori

### ✏️ Menambah / Mengubah Kategori

1. Fork repo ini  
2. Buka file `AutoSortDownloads.ps1`  
3. Temukan bagian:
   ```powershell
   $Categories = @{
       'Documents'     = @('doc','docx','pdf','txt')
       ...
   }
   ```
4. Tambahkan atau ubah misalnya:
   ```powershell
   'Ebooks' = @('epub','mobi','pdf')
   ```
5. Simpan file

---

### 🧪 Menjalankan Secara Manual Tanpa EXE

```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
.\AutoSortDownloads.ps1
```

---

## 📦 Membuat Ulang EXE

Setelah memodifikasi `AutoSortDownloads.ps1`, Anda bisa membuat ulang `category.exe`.

1. **Install modul PS2EXE** (jika belum):
   ```powershell
   Install-Module PS2EXE -Scope CurrentUser -Force
   ```
2. **Compile** skrip menjadi EXE:
   ```powershell
   Invoke-PS2EXE `
     -InputFile .\AutoSortDownloads.ps1 `
     -OutputFile .\category.exe `
     -NoConsole
   ```
3. **Verify** file `category.exe` muncul di folder  
4. **Publish** ke GitHub Releases:
   - Buka tab **Releases**  
   - Klik **Draft a new release**  
   - Isi tag (misal `v1.0.1`)  
   - Drag `category.exe` ke kolom Assets  
   - Klik **Publish release**

---

## 🛠️ Dukungan & Dokumentasi

- **Panduan Lengkap**: README ini 😄  
- **Kode Sumber**:
  - `AutoSortDownloads.ps1` – watcher utama  
  - `InstallAndRun-AutoSort.ps1` – installer manual (jika tidak pakai EXE)

- **Laporkan Masalah / Ide**:  
  [https://github.com/merdekasiberlab/category/issues](https://github.com/merdekasiberlab/category/issues)

---

## 🤝 Terima Kasih
