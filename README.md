## v1.0.0 – Rilis Pertama

**category** adalah aplikasi Windows “satu-klik” yang secara otomatis mengelompokkan file di folder Downloads Anda ke dalam sub-folder berdasarkan kategori dan ekstensi—tanpa perlu hak admin atau konfigurasi rumit.

### 📦 Asset
- **category.exe** – Installer EXE satu-klik (tanpa perlu hak admin).  

### ✨ Fitur Utama
- **Instalasi sekali klik**  
  Jalankan `category.exe` sekali, sistem akan membuat folder instalasi dan shortcut di Startup secara otomatis.  
- **Aktif setelah login**  
  Proses pemantauan berjalan di latar belakang setiap kali Anda sign out & sign in (atau restart) PC—cukup sekali setup!  
- **Pengelompokan dua tingkat**  
  1. **Level 1:** Kategori umum (Documents, Images, Audio, Video, dll.)  
  2. **Level 2:** Sub-folder berdasarkan ekstensi (misalnya `\Documents\docx`, `\Images\png`).  
- **Ringan & tanpa service**  
  Menjalankan proses biasa di latar, minim konsumsi sumber daya.

### 🚀 Cara Pakai
1. **Download** `category.exe` dari daftar asset di bawah.  
2. **Double-klik** `category.exe` sekali untuk install.  
3. **Logout & Login** (atau restart) Windows Anda.  
4. **Unduh** file baru di browser—periksa sub-folder `Downloads\<Kategori>\<Ekstensi>\…` untuk hasilnya.

### 🛠️ Dukungan & Dokumentasi
- **Panduan Lengkap**: [README.md](README.md)  
- **Kode Sumber**:  
  - Installer PS1: [InstallAndRun-AutoSort.ps1](https://github.com/merdekasiberlab/category/blob/main/InstallAndRun-AutoSort.ps1)  
  - Watcher PS1: [AutoSortDownloads.ps1](https://github.com/merdekasiberlab/category/blob/main/AutoSortDownloads.ps1)  
- **Laporkan Masalah**: Buka [Issue](https://github.com/merdekasiberlab/category/issues)

---

Terima kasih telah menggunakan **category**! 🎉  
