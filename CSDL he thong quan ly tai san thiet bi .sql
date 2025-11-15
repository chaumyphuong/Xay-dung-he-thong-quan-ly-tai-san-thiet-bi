--tạo database
create database AMS_pttk3
go
use AMS_pttk3
go
--tạo bảng tài sản
create table tai_san
(
	maTB char(4) primary key not null,
	tenTB nvarchar(35) not null,
	tgmua date not null,
	tgkhauhao date not null,
	tinhtrang nvarchar(70) not null,
	giatri money not null,
	mota nvarchar(200),
	HDSD nvarchar(300)
)
go
--tạo bảng dự án
create table du_an
(
	maDA char(4) primary key,
	tenDA nvarchar(70) not null,
	mota nvarchar(200),
	khachhang nvarchar(40),
	ngaybatdau date not null,
	ngayketthuc date not null
)
go
--tạo bảng phòng ban
create table phong_ban
(
maphong char(4) primary key not null,
tenphong nvarchar (30) not null
)
go
--tạo bảng nhân viên
create table nhan_vien
(
maNV char (4) primary key,
ho nvarchar (15) not null,
tendem nvarchar (30) not null,
ten nvarchar (15) not null,
diachi nvarchar (100) not null,
chucvu nvarchar (25) not null,
SDT varchar (12) not null,
gioitinh char (1) not null,
ngaysinh date,
luong money not null,
maphong char (4) not null
)
go

--tạo bảng tài khoản
create table tai_khoan 
(
tenTK varchar(20) unique,
matkhau varchar(20) not null,
maNV char(4) not null
)
go
--tạo bảng biên bản giao
create table bienban_giao
(
	maBBG char(5) not null,
	maTB char(4) not null,
	maNV char(4) not null,
	tggiao date not null,
	maNVgiao char(4) not null,
	constraint pk_mabbg_matb primary key(maBBG, maTB)
)
go

--tạo bảng biên bản trả
create table bienban_tra
(
maBBT char(5) not null,
maNV char (4) not null,
tgtra date not null,
maNVnhan char(4) not null,
maTB char(4) not null,
constraint pk_mabbt_matb primary key(maBBT, maTB)
)
go

-- tạo bảng tham gia
create table tham_gia
(
maDA char(4) not null,
maNV char(4) not null,
vaitro nvarchar(25) null
constraint pk_mada_manv primary key(maDA, maNV)
)
go
--tạo bảng linh kiện
create table thietbi_con
(
	maTB char(4) not null,
	maTBC char(4) not null,
	constraint pk_malk_mats primary key (maTB, maTBC)
)
go
--tạo quan hệ các bảng
alter table nhan_vien
add constraint fk_nv_maphong foreign key (maphong) references phong_ban (maphong)
go
alter table tai_khoan
add constraint fk_tk_manv foreign key (maNV) references nhan_vien (maNV)
go
alter table tham_gia
add constraint fk_tg_mada foreign key (maDA) references du_an (maDA),
constraint fk_tg_manv foreign key (maNV) references nhan_vien (maNV)
go
alter table bienban_giao
add constraint fk_bbg_manv foreign key (maNV) references nhan_vien (maNV)
go
alter table bienban_giao
add constraint fk_bbg_manvgiao foreign key (maNVgiao) references nhan_vien (maNV)
go
alter table bienban_tra
add constraint fk_bbt_manv foreign key (maNV) references nhan_vien (maNV)
go
alter table bienban_tra
add constraint fk_bbt_manvnhan foreign key (maNVnhan) references nhan_vien (maNV)
go
alter table thietbi_con
add constraint fk_bbt_matb foreign key (maTB) references tai_san (maTB)
go
alter table thietbi_con
add constraint fk_bbt_matbc foreign key (maTBC) references tai_san (maTB)
go
alter table [dbo].[bienban_giao]
add constraint fk_ct_giao foreign key (maTB) references tai_san (maTB)
go
alter table [dbo].[bienban_giao]
add constraint fk_ct_giao1 foreign key (maBBG) references bienban_giao (maBBG)
go
alter table [dbo].[bienban_tra]
add constraint fk_ct_tra foreign key (maTB) references tai_san (maTB)
go
alter table [dbo].[bienban_tra]
add constraint fk_ct_tra1 foreign key (maBBT) references bienban_tra (maBBT)
go
alter table tai_san
add constraint fk_ts_nv foreign key (maNV) references nhan_vien(maNV)
go