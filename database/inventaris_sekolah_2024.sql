-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jan 22, 2025 at 02:56 PM
-- Server version: 8.0.30
-- PHP Version: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

CREATE DATABASE IF NOT EXISTS inventaris_sekolah_2024;

USE mysql;
CREATE USER IF NOT EXISTS 'apps'@'%' IDENTIFIED BY 'kel2x6j';
GRANT ALL PRIVILEGES ON inventaris_sekolah_2024.* TO 'apps'@'%';


USE inventaris_sekolah_2024;

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `inventaris_sekolah_2024`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`apps`@`%` PROCEDURE `update_qty_sisa` (IN `p_kode_barang` VARCHAR(20), IN `p_old_qty` INT, IN `p_new_qty` INT)   BEGIN
    DECLARE v_current_qty_sisa INT;

    SELECT qty_sisa INTO v_current_qty_sisa
    FROM barang
    WHERE kode_barang = p_kode_barang COLLATE utf8mb4_general_ci;

    SET v_current_qty_sisa = p_new_qty - p_old_qty +v_current_qty_sisa;

    UPDATE barang
    SET qty_sisa = v_current_qty_sisa,
        qty = p_new_qty
    WHERE kode_barang = p_kode_barang COLLATE utf8mb4_general_ci;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `nip_admin` int NOT NULL,
  `nama_admin` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `alamat_admin` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `telp_admin` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `username` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`nip_admin`, `nama_admin`, `alamat_admin`, `telp_admin`, `username`, `password`) VALUES
(20240726, 'admin', 'Jl. jauh', '0814144144', 'admin', 'admin123'),
(202405001, 'Dhika', 'Jl. Narogong', '08134567712', 'dhika', 'dhika123');

-- --------------------------------------------------------

--
-- Table structure for table `aktivitas`
--

CREATE TABLE `aktivitas` (
  `id_aktivitas` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `jenis_aktivitas` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `aktivitas`
--

INSERT INTO `aktivitas` (`id_aktivitas`, `jenis_aktivitas`) VALUES
('AKT001', 'Penjualan'),
('AKT002', 'Peminjaman'),
('AKT003', 'Pengembalian');

-- --------------------------------------------------------

--
-- Table structure for table `barang`
--

CREATE TABLE `barang` (
  `kode_barang` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `nama_barang` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `id_jns_brg` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `harga_per_barang` double NOT NULL,
  `qty` int NOT NULL,
  `qty_sisa` int NOT NULL,
  `harga_total_barang` double NOT NULL,
  `tanggal_masuk` date NOT NULL,
  `id_invoice` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `sumber_dana` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `kondisi_barang` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `nama_admin` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `tgl_input_brg` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `barang`
--

INSERT INTO `barang` (`kode_barang`, `nama_barang`, `id_jns_brg`, `harga_per_barang`, `qty`, `qty_sisa`, `harga_total_barang`, `tanggal_masuk`, `id_invoice`, `sumber_dana`, `kondisi_barang`, `status`, `nama_admin`, `tgl_input_brg`) VALUES
('BRG001', 'Spidol', 'JBG002', 15000, 10, 5, 150000, '2024-05-19', 'INV001', 'Kas', 'Baru', 'Updated', 'dhika', '2024-05-17'),
('BRG002', 'Meja', 'JBG003', 2000000, 6, 6, 12000000, '2024-05-12', 'INV002', 'Dana Umum', 'Baru', 'Updated', 'dhika', '2024-05-17'),
('BRG003', 'Proyektor', 'JBG001', 5000000, 4, 4, 20000000, '2024-05-26', 'INV003', 'Hibah', 'Bekas', 'Updated', 'dhika', '2024-05-17'),
('BRG004', 'Laptop', 'JBG001', 7200000, 2, 1, 14400000, '2024-05-26', 'INV003', 'Kas', 'Baru', 'Updated', 'admin', '2025-01-18');

-- --------------------------------------------------------

--
-- Table structure for table `invoice`
--

CREATE TABLE `invoice` (
  `id_invoice` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `no_invoice` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `tgl_beli` date NOT NULL,
  `total_bayar` decimal(20,2) NOT NULL,
  `status_pembayaran` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `kode_supplier` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `nama_pengirim` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `tgl_dikirim` date NOT NULL,
  `id_pegawai` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `nama_penerima` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `tgl_diterima` date NOT NULL,
  `nama_admin` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `tgl_input_brg` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `invoice`
--

INSERT INTO `invoice` (`id_invoice`, `no_invoice`, `tgl_beli`, `total_bayar`, `status_pembayaran`, `kode_supplier`, `nama_pengirim`, `tgl_dikirim`, `id_pegawai`, `nama_penerima`, `tgl_diterima`, `nama_admin`, `tgl_input_brg`) VALUES
('INV001', '202405171032', '2024-05-17', '500000.00', 'Lunas', NULL, 'CV ATK Baru', '2024-05-18', 'PGW001', 'Nakashima Yuzuki', '2024-05-19', 'dhika', '2024-05-17'),
('INV002', '202405101036', '2024-05-10', '100000000.00', 'Lunas', 'SUP004', 'CV Bangun Bangunin', '2024-05-11', 'PGW001', 'Nakashima Yuzuki', '2024-05-12', 'dhika', '2024-05-17'),
('INV003', '202405241934', '2024-05-24', '50000000.00', 'Lunas', 'SUP003', 'PT Crypto Nih Bos', '2024-05-25', 'PGW003', 'Takeuchi Kirari', '2024-05-26', 'kel2', '2024-05-17'),
('INV004', '202407260248', '2024-07-26', '15000000.00', 'Lunas', 'SUP005', 'PT Syalala', '2024-07-26', 'PGW003', 'Takeuchi Kirari', '2024-07-26', 'dhika', '2024-07-26');

-- --------------------------------------------------------

--
-- Table structure for table `jabatan`
--

CREATE TABLE `jabatan` (
  `id_jabatan` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `nama_jabatan` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `jabatan`
--

INSERT INTO `jabatan` (`id_jabatan`, `nama_jabatan`) VALUES
('JBT001', 'Bendahara'),
('JBT002', 'Penanggung Jawab');

-- --------------------------------------------------------

--
-- Table structure for table `jenis_barang`
--

CREATE TABLE `jenis_barang` (
  `id_jns_brg` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `jns_brg` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `jenis_barang`
--

INSERT INTO `jenis_barang` (`id_jns_brg`, `jns_brg`) VALUES
('JBG001', 'Elektronik'),
('JBG002', 'Habis Pakai'),
('JBG003', 'Furnitur');

-- --------------------------------------------------------

--
-- Table structure for table `pegawai`
--

CREATE TABLE `pegawai` (
  `id_pegawai` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `nip_pegawai` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `nama_pegawai` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `jk_pegawai` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `alamat_pegawai` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `id_jabatan` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `telp_pegawai` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pegawai`
--

INSERT INTO `pegawai` (`id_pegawai`, `nip_pegawai`, `nama_pegawai`, `jk_pegawai`, `alamat_pegawai`, `id_jabatan`, `telp_pegawai`) VALUES
('PGW001', '20240517001', 'Nakashima Yuzuki', 'Perempuan', 'Jl. Sakurazaka No.46, Fukuoka, Jepang', 'JBT001', '08123242459'),
('PGW002', '20240517002', 'Dani Wedang Jahe', 'Laki-Laki', 'Jl. Kemajuan Bro No.99, Bekasi, Jawa Barat', 'JBT002', '08992312144'),
('PGW003', '20240517003', 'Takeuchi Kirari', 'Perempuan', 'Jl. Hinatazaka No.46, Hiroshima, Jepang', 'JBT001', '08512345678'),
('PGW004', '20240517004', 'Bagas Rendang', 'Laki-Laki', 'Jl. Rendang No.33, Rawalumbalumba, Bekasi', 'JBT002', '08319923378'),
('PGW005', '20240517005', 'Rahmat Mofumofu', 'Laki-Laki', 'Jl. Menuju RahmatMu No.1 Kota Bekasi', 'JBT002', '08799886612');

-- --------------------------------------------------------

--
-- Table structure for table `provinsi`
--

CREATE TABLE `provinsi` (
  `id` int NOT NULL,
  `nama_provinsi` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `provinsi`
--

INSERT INTO `provinsi` (`id`, `nama_provinsi`) VALUES
(1, 'Aceh'),
(2, 'Sumatera Utara'),
(3, 'Sumatera Barat'),
(4, 'Riau'),
(5, 'Kepulauan Riau'),
(6, 'Jambi'),
(7, 'Sumatera Selatan'),
(8, 'Bengkulu'),
(9, 'Lampung'),
(10, 'Kepulauan Bangka Belitung'),
(11, 'DKI Jakarta'),
(12, 'Jawa Barat'),
(13, 'Jawa Tengah'),
(14, 'DI Yogyakarta'),
(15, 'Jawa Timur'),
(16, 'Banten'),
(17, 'Bali'),
(18, 'Nusa Tenggara Barat'),
(19, 'Nusa Tenggara Timur'),
(20, 'Kalimantan Barat'),
(21, 'Kalimantan Tengah'),
(22, 'Kalimantan Selatan'),
(23, 'Kalimantan Timur'),
(24, 'Kalimantan Utara'),
(25, 'Sulawesi Utara'),
(26, 'Sulawesi Tengah'),
(27, 'Sulawesi Selatan'),
(28, 'Sulawesi Tenggara'),
(29, 'Gorontalo'),
(30, 'Sulawesi Barat'),
(31, 'Maluku'),
(32, 'Maluku Utara'),
(33, 'Papua Barat'),
(34, 'Papua'),
(35, 'Papua Selatan'),
(36, 'Papua Tengah'),
(37, 'Papua Pegunungan'),
(38, 'Papua Barat Daya');

-- --------------------------------------------------------

--
-- Table structure for table `ruangan`
--

CREATE TABLE `ruangan` (
  `kode_ruangan` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `nama_ruangan` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `deskripsi` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `id_pegawai` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ruangan`
--

INSERT INTO `ruangan` (`kode_ruangan`, `nama_ruangan`, `deskripsi`, `id_pegawai`) VALUES
('RNG001', 'Kelas 1A', 'Kelas terbaik di muka bumi', 'PGW002'),
('RNG002', 'Kelas 2B', 'Kelas biasa biasa aja', 'PGW004'),
('RNG003', 'Kelas 3C', 'Kelassss abangkuhh', 'PGW002'),
('RNG005', 'Kelas 4D', 'Kelas 4D', 'PGW004');

-- --------------------------------------------------------

--
-- Table structure for table `sekolah`
--

CREATE TABLE `sekolah` (
  `id_sekolah` int NOT NULL,
  `npsn` int NOT NULL,
  `nama_sekolah` varchar(30) NOT NULL,
  `alamat_sekolah` text NOT NULL,
  `rtrw` varchar(20) NOT NULL,
  `kota` varchar(30) NOT NULL,
  `nama_provinsi` varchar(255) NOT NULL,
  `kode_pos` int NOT NULL,
  `telp_sekolah` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `sekolah`
--

INSERT INTO `sekolah` (`id_sekolah`, `npsn`, `nama_sekolah`, `alamat_sekolah`, `rtrw`, `kota`, `nama_provinsi`, `kode_pos`, `telp_sekolah`) VALUES
(4, 202236281, 'SD SETIA BEKASI TIMUR', 'Jl. P. Irian Jaya I, Kecamatan Bekasi Timur', 'RT. 02/RW. 018', 'Kota Bekasi', 'Jawa Barat', 17111, '0218816813');

-- --------------------------------------------------------

--
-- Stand-in structure for view `status_barang`
-- (See below for the actual view)
--
CREATE TABLE `status_barang` (
`jmlbrg_tersisa` decimal(33,0)
,`last_tgl_trx` datetime
,`status_brg` varchar(30)
,`vbarang` varchar(40)
,`vjmlbrgtrx` int
,`vkbarang` varchar(20)
,`vnmpegawai` varchar(30)
,`vruangan` varchar(20)
);

-- --------------------------------------------------------

--
-- Table structure for table `supplier`
--

CREATE TABLE `supplier` (
  `kode_supplier` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `nama_supplier` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `alamat_supplier` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `telp_supplier` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `email_supplier` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `supplier`
--

INSERT INTO `supplier` (`kode_supplier`, `nama_supplier`, `alamat_supplier`, `telp_supplier`, `email_supplier`) VALUES
('SUP001', 'PT Best Corporation Promax', 'Jl. Menuju Berkah No. Riba', '02199988878', 'ptbestcopo@yassalam.com'),
('SUP002', 'CV Curriculum Vitae', 'Jl. Ekspetasi Gaji No. Nego ', '0213871271', 'cvcv@gmail.com'),
('SUP003', 'PT Crypto Nih Bos', 'Jl. Mclaren Volkadot No. 69', '09933445566', 'crypto@ultinolan.com'),
('SUP004', 'CV Bangun Bangunin', 'Jl. Pembangunan 20', '02177766341', 'bangun@gmail.com'),
('SUP005', 'PT SYALALA', 'Jl. Syalala', '08121341414', 'syalala@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `transaksi`
--

CREATE TABLE `transaksi` (
  `id_trx` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `id_aktivitas` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `tgl_trx` datetime NOT NULL,
  `kode_barang` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `jml_brg_trx` int NOT NULL,
  `sts_brg_trx` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `kode_ruangan` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `id_pegawai` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `nama_admin` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `tgl_input` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `transaksi`
--

INSERT INTO `transaksi` (`id_trx`, `id_aktivitas`, `tgl_trx`, `kode_barang`, `jml_brg_trx`, `sts_brg_trx`, `kode_ruangan`, `id_pegawai`, `nama_admin`, `tgl_input`) VALUES
('TRX001', 'AKT002', '2024-05-17 13:19:21', 'BRG001', 6, 'Pakai', 'RNG001', 'PGW002', 'dhika', '2024-05-17'),
('TRX002', 'AKT003', '2024-05-17 13:19:50', 'BRG001', 1, 'Selesai Pakai', 'RNG001', 'PGW002', 'dhika', '2024-05-17'),
('TRX003', 'AKT003', '2024-05-17 13:23:10', 'BRG001', 1, 'Rusak', 'RNG001', 'PGW002', 'dhika', '2024-05-17'),
('TRX004', 'AKT002', '2025-01-19 02:33:06', 'BRG004', 1, 'Pakai', 'RNG005', 'PGW004', 'admin', '2025-01-19');

--
-- Triggers `transaksi`
--
DELIMITER $$
CREATE TRIGGER `after_insert_barang` AFTER INSERT ON `transaksi` FOR EACH ROW BEGIN
    UPDATE barang
    SET status = 'Updated'
    WHERE kode_barang = NEW.kode_barang;

    
    IF NEW.id_aktivitas = 'AKT001' OR NEW.id_aktivitas = 'AKT002' THEN
        UPDATE barang
        SET qty_sisa = qty_sisa - NEW.jml_brg_trx
        WHERE kode_barang = NEW.kode_barang;
    
    ELSEIF NEW.id_aktivitas = 'AKT003' AND NEW.sts_brg_trx != 'Rusak' THEN
        UPDATE barang
        SET qty_sisa = qty_sisa + NEW.jml_brg_trx
        WHERE kode_barang = NEW.kode_barang;
    ELSEIF NEW.id_aktivitas = 'AKT003' AND NEW.sts_brg_trx = 'Rusak' THEN
        UPDATE barang
        SET qty_sisa = qty_sisa + 0
        WHERE kode_barang = NEW.kode_barang;
    END IF;

END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_update_transaksi` AFTER UPDATE ON `transaksi` FOR EACH ROW BEGIN
    UPDATE barang
    SET status = 'Updated'
    WHERE kode_barang = NEW.kode_barang;

    IF OLD.id_aktivitas IN ('AKT001', 'AKT002') THEN
        UPDATE barang
        SET qty_sisa = qty_sisa + OLD.jml_brg_trx
        WHERE kode_barang = OLD.kode_barang;
    ELSEIF OLD.id_aktivitas = 'AKT003' AND OLD.sts_brg_trx != 'Rusak' THEN
        UPDATE barang
        SET qty_sisa = qty_sisa - OLD.jml_brg_trx
        WHERE kode_barang = OLD.kode_barang;
    ELSEIF OLD.id_aktivitas = 'AKT003' AND OLD.sts_brg_trx = 'Rusak' THEN
        UPDATE barang
        SET qty_sisa = qty_sisa - 0
        WHERE kode_barang = OLD.kode_barang;
    END IF;

    IF NEW.id_aktivitas = 'AKT001' OR NEW.id_aktivitas = 'AKT002' THEN
        UPDATE barang
        SET qty_sisa = qty_sisa - NEW.jml_brg_trx
        WHERE kode_barang = NEW.kode_barang;
    ELSEIF NEW.id_aktivitas = 'AKT003' AND NEW.sts_brg_trx != 'Rusak' THEN
        UPDATE barang
        SET qty_sisa = qty_sisa + NEW.jml_brg_trx
        WHERE kode_barang = NEW.kode_barang;
    ELSEIF NEW.id_aktivitas = 'AKT003' AND NEW.sts_brg_trx = 'Rusak' THEN
        UPDATE barang
        SET qty_sisa = qty_sisa + 0
        WHERE kode_barang = NEW.kode_barang;
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `cek_stok_sebelum_transaksi` BEFORE INSERT ON `transaksi` FOR EACH ROW BEGIN
    DECLARE stok_tersedia INT;
    DECLARE stok_max INT;

    
    SELECT qty_sisa INTO stok_tersedia FROM barang WHERE kode_barang = NEW.kode_barang;
    SELECT qty INTO stok_max FROM barang WHERE kode_barang = NEW.kode_barang;

    
    IF NEW.id_aktivitas = 'AKT003' AND (stok_tersedia + NEW.jml_brg_trx) > stok_max THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Transaksi melebihi nilai barang awal!';
    END IF;

    
    IF NEW.id_aktivitas = 'AKT001' OR NEW.id_aktivitas = 'AKT002' THEN
        IF (stok_tersedia - NEW.jml_brg_trx) < 0 THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Transaksi tidak normal';
        END IF;
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `cek_stok_sebelum_update_trx` BEFORE UPDATE ON `transaksi` FOR EACH ROW BEGIN
    DECLARE stok_tersedia INT;
    DECLARE stok_max INT;

    
    SELECT qty_sisa INTO stok_tersedia FROM barang WHERE kode_barang = NEW.kode_barang;
    SELECT qty INTO stok_max FROM barang WHERE kode_barang = NEW.kode_barang;

    
    IF NEW.id_aktivitas = 'AKT003' AND (0 + NEW.jml_brg_trx) > stok_max THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Transaksi melebihi nilai barang awal!';
    END IF;

    
    IF NEW.id_aktivitas = 'AKT001' OR NEW.id_aktivitas = 'AKT002' THEN
        IF (stok_tersedia - NEW.jml_brg_trx) < 0 THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Transaksi tidak normal';
        END IF;
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Structure for view `status_barang`
--
DROP TABLE IF EXISTS `status_barang`;

CREATE ALGORITHM=UNDEFINED DEFINER=`god`@`%` SQL SECURITY DEFINER VIEW `status_barang`  AS SELECT `b`.`kode_barang` AS `vkbarang`, `b`.`nama_barang` AS `vbarang`, `t`.`sts_brg_trx` AS `status_brg`, `t`.`tgl_trx` AS `last_tgl_trx`, `r`.`nama_ruangan` AS `vruangan`, `p`.`nama_pegawai` AS `vnmpegawai`, `t`.`jml_brg_trx` AS `vjmlbrgtrx`, (`b`.`qty_sisa` - (select coalesce(sum(`transaksi`.`jml_brg_trx`),0) from `transaksi` where ((`transaksi`.`sts_brg_trx` = 'Rusak') and (`transaksi`.`kode_barang` = `b`.`kode_barang`)))) AS `jmlbrg_tersisa` FROM (((`barang` `b` join (select `t1`.`kode_barang` AS `kode_barang`,`t1`.`sts_brg_trx` AS `sts_brg_trx`,`t1`.`tgl_trx` AS `tgl_trx`,`t1`.`jml_brg_trx` AS `jml_brg_trx`,`t1`.`kode_ruangan` AS `kode_ruangan`,`t1`.`id_pegawai` AS `id_pegawai`,row_number() OVER (PARTITION BY `t1`.`kode_barang` ORDER BY `t1`.`tgl_trx` desc )  AS `rn` from `transaksi` `t1`) `t` on(((`b`.`kode_barang` = `t`.`kode_barang`) and (`t`.`rn` = 1)))) join `ruangan` `r` on((`t`.`kode_ruangan` = `r`.`kode_ruangan`))) join `pegawai` `p` on((`t`.`id_pegawai` = `p`.`id_pegawai`)))  ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`nip_admin`);

--
-- Indexes for table `aktivitas`
--
ALTER TABLE `aktivitas`
  ADD PRIMARY KEY (`id_aktivitas`);

--
-- Indexes for table `barang`
--
ALTER TABLE `barang`
  ADD PRIMARY KEY (`kode_barang`),
  ADD KEY `barang_ibfk_1` (`id_jns_brg`),
  ADD KEY `barang_ibfk_2` (`id_invoice`);

--
-- Indexes for table `invoice`
--
ALTER TABLE `invoice`
  ADD PRIMARY KEY (`id_invoice`),
  ADD KEY `invoice_ibfk_1` (`kode_supplier`),
  ADD KEY `invoice_ibfk_2` (`id_pegawai`);

--
-- Indexes for table `jabatan`
--
ALTER TABLE `jabatan`
  ADD PRIMARY KEY (`id_jabatan`);

--
-- Indexes for table `jenis_barang`
--
ALTER TABLE `jenis_barang`
  ADD PRIMARY KEY (`id_jns_brg`);

--
-- Indexes for table `pegawai`
--
ALTER TABLE `pegawai`
  ADD PRIMARY KEY (`id_pegawai`),
  ADD KEY `pegawai_ibfk_1` (`id_jabatan`);

--
-- Indexes for table `provinsi`
--
ALTER TABLE `provinsi`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ruangan`
--
ALTER TABLE `ruangan`
  ADD PRIMARY KEY (`kode_ruangan`),
  ADD KEY `ruangan_ibfk_1` (`id_pegawai`);

--
-- Indexes for table `sekolah`
--
ALTER TABLE `sekolah`
  ADD PRIMARY KEY (`id_sekolah`);

--
-- Indexes for table `supplier`
--
ALTER TABLE `supplier`
  ADD PRIMARY KEY (`kode_supplier`);

--
-- Indexes for table `transaksi`
--
ALTER TABLE `transaksi`
  ADD PRIMARY KEY (`id_trx`),
  ADD KEY `transaksi_ibfk_1` (`id_aktivitas`),
  ADD KEY `transaksi_ibfk_2` (`kode_barang`),
  ADD KEY `transaksi_ibfk_3` (`kode_ruangan`),
  ADD KEY `transaksi_ibfk_4` (`id_pegawai`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `provinsi`
--
ALTER TABLE `provinsi`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `sekolah`
--
ALTER TABLE `sekolah`
  MODIFY `id_sekolah` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `barang`
--
ALTER TABLE `barang`
  ADD CONSTRAINT `barang_ibfk_1` FOREIGN KEY (`id_jns_brg`) REFERENCES `jenis_barang` (`id_jns_brg`) ON DELETE SET NULL ON UPDATE SET NULL,
  ADD CONSTRAINT `barang_ibfk_2` FOREIGN KEY (`id_invoice`) REFERENCES `invoice` (`id_invoice`) ON DELETE SET NULL ON UPDATE SET NULL;

--
-- Constraints for table `invoice`
--
ALTER TABLE `invoice`
  ADD CONSTRAINT `invoice_ibfk_1` FOREIGN KEY (`kode_supplier`) REFERENCES `supplier` (`kode_supplier`) ON DELETE SET NULL ON UPDATE SET NULL,
  ADD CONSTRAINT `invoice_ibfk_2` FOREIGN KEY (`id_pegawai`) REFERENCES `pegawai` (`id_pegawai`) ON DELETE SET NULL ON UPDATE SET NULL;

--
-- Constraints for table `pegawai`
--
ALTER TABLE `pegawai`
  ADD CONSTRAINT `pegawai_ibfk_1` FOREIGN KEY (`id_jabatan`) REFERENCES `jabatan` (`id_jabatan`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `transaksi`
--
ALTER TABLE `transaksi`
  ADD CONSTRAINT `transaksi_ibfk_1` FOREIGN KEY (`id_aktivitas`) REFERENCES `aktivitas` (`id_aktivitas`) ON DELETE SET NULL ON UPDATE SET NULL,
  ADD CONSTRAINT `transaksi_ibfk_2` FOREIGN KEY (`kode_barang`) REFERENCES `barang` (`kode_barang`) ON DELETE SET NULL ON UPDATE SET NULL,
  ADD CONSTRAINT `transaksi_ibfk_3` FOREIGN KEY (`kode_ruangan`) REFERENCES `ruangan` (`kode_ruangan`) ON DELETE SET NULL ON UPDATE SET NULL,
  ADD CONSTRAINT `transaksi_ibfk_4` FOREIGN KEY (`id_pegawai`) REFERENCES `pegawai` (`id_pegawai`) ON DELETE SET NULL ON UPDATE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
