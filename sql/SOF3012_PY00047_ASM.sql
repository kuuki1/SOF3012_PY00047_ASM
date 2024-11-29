create database SOF3012_PY00047_ASM
go
use SOF3012_PY00047_ASM
go

-- Tạo bảng người dùng
create table Users
(
	id int primary key identity,
	username varchar(255) unique not null,			-- Mã đăng nhập
	fullname nvarchar(255) not null,				-- Họ và tên
	password varchar(255) not null,					-- Mật khẩu
	email varchar(255) not null,					-- Email
	isAdmin bit default 0 not null,					-- Vai trò (0: người xem, 1: quản trị)
	isActive bit default 1,							-- Hành động (0: ẩn người dùng, 1: hiển thị người dùng)
);
go

-- Tạo bảng thể loại
create table Categories
(
	id int identity(1,1) primary key,		-- Mã loại
	name nvarchar(255) not null,			-- Tên loại tên
);
go

-- Tạo bảng video
create table Video
(
	id int identity(1,1) primary key,		-- Mã video
	title nvarchar(255) not null,			-- Tiêu đề
	videoUrl varchar(255) not null,			-- Đường dẫn video(từ youtube, vimeo,...)
	poster varchar(255) null,				-- Áp phích
	categoryid int not null,				-- Mã thể loại
	viewcount int default 0,				-- Người xem
	likecuont int default 0,				-- Số lược thích
	sharecuont int default 0,				-- Số lược share
	commentcuont int default 0,				-- Số bình luận
	description nvarchar(max),				-- Mô tả video
	isActive bit default 1,					-- Hành động (0: ẩn video, 1: hiển thị video)
	userid int not null,					-- Người đăng
	foreign key	(userid) references Users(id),	
	foreign key (categoryid) references categories(id),
);
go

-- Tạo bảng lịch sử xem 
create table History
(
	id int identity(1,1) primary key,				-- Mã lịch sử
	userid int not null,							-- Mã người dùng
	videoid int not null,							-- Mã video
	viewDate datetime default getDate() not null,	-- Ngày xem (mặc định ngày hiện tại)
	isLiked bit default 0 not null,					-- Đã thích hay chưa (0: chưa, 1: rồi)
	likedDate datetime null,						-- Ngày thích
	foreign key (userid) references users(id),
	foreign key (videoid) references video(id),
);
go

-- Tạo bảng chia sẽ
create table Share
(
	id int identity(1,1) primary key,				-- Mã chia sẽ
	userid int not null,							-- Mã người dùng
	videoid int not null,							-- Mã video
	sharedate date default getDate(),				-- Ngày chia sẽ (mặc định ngày hiện tại)
	shareemail varchar(255) not null,				-- Email được chia sẽ
	foreign key (userid) references users(id),
	foreign key (videoid) references video(id),
);
go

-- Tạo bảng bình luận
create table Comment
(
	id int identity(1,1) primary key,				-- Mã chia sẽ
	userid int not null,							-- Mã người dùng
	videoid int not null,							-- Mã video
	commentdate date default getDate(),				-- Ngày bình luận (mặc định ngày hiện tại)
	content nvarchar(max) not null,					-- Nội dung
	foreign key (userid) references users(id),
	foreign key (videoid) references video(id),
);
go

select * from share

INSERT INTO Users (username, fullname, password, email, isAdmin, isActive)
VALUES
('admin', N'Quản trị viên', 'admin', 'admin@example.com', 1, 1),
('user1', N'Nguyễn Văn A', 'user123', 'user1@example.com', 0, 1),
('user2', N'Trần Thị B', 'user123', 'user2@example.com', 0, 1),
('user3', N'Lê Văn C', 'user123', 'user3@example.com', 0, 0);

INSERT INTO Categories (name)
VALUES
(N'Âm nhạc'),
(N'Phim ảnh'),
(N'Tin tức'),
(N'Giải trí'),
(N'Giáo dục');

INSERT INTO Video (title, videoUrl, poster, categoryid, viewcount, likecuont, sharecuont, commentcuont, description, isActive, userid)
VALUES
(N'Bài hát vui nhộn', 'BsWJYM9qgr0', 'poster1.jpg', 1, 100, 10, 5, 3, N'Video âm nhạc vui nhộn dành cho trẻ em', 1, 2),
(N'Phim ngắn hay', 'QnGnSDFgRQI', 'poster2.jpg', 2, 500, 50, 20, 10, N'Phim ngắn cảm động về cuộc sống', 1, 3),
(N'Tin tức hôm nay', '00cEQtvjvso', 'poster3.jpg', 3, 300, 30, 15, 8, N'Tin tức mới nhất về tình hình thế giới', 1, 2),
(N'Hài kịch vui nhộn', 'm2pLB8mQ0U8', 'poster4.jpg', 4, 200, 25, 10, 5, N'Hài kịch giúp bạn cười sảng khoái', 0, 1);

INSERT INTO Comment (userid, videoid, commentdate, content)
VALUES
(2, 1, '2024-11-15', N'Video rất hay!'),
(3, 2, '2024-11-16', N'Tôi rất thích nội dung này.'),
(2, 3, '2024-11-17', N'Hữu ích và thú vị.'),
(1, 4, '2024-11-18', N'Hài kịch này thật hài hước.');

