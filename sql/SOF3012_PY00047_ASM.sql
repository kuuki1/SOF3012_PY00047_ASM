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

select * from Users

INSERT INTO Users (username, fullname, password, email, isAdmin, isActive)
VALUES
('admin', N'Quản trị viên', 'e38RDrc54a2fyuijyxWsCQ==javaxEGlnU+8xwGdXK7Zlc7/P7Q==javaxYGrJSoSlmyyXCbosyTWH/Q==', 'admin@example.com', 1, 1),
('user', N'Nguyễn Văn A', '3/Iv4sxO61yB13OhuEcWjg==javaxQqeFFzazVB/Zo68aEott9w==javaxNKU9M/1OIxH4iVEFlUU5tQ==', 'user@example.com', 0, 1);

INSERT INTO Categories (name) VALUES
(N'Giải trí'),
(N'Tin tức'),
(N'Giáo dục'),
(N'Ẩm thực'),
(N'Sức khỏe'),
(N'Công nghệ'),
(N'Thể thao');

-- Video cho thể loại "Giải trí"
INSERT INTO Video (title, videoUrl, poster, categoryid, viewcount, likecuont, sharecuont, commentcuont, description, isActive, userid) VALUES
(N'Gió Mang Hương Về Giờ Em Ở Đâu ♫ Nhạc Buồn TikTok Hay Nhất Tháng 6 2024', 'https://www.youtube.com/watch?v=G1l9hH8HiF8', 'https://example.com/poster1', 1, 0, 0, 0, 0, N'Mô tả video Giải trí 1', 1, 1),
(N'Những Bản Nhạc Mang Âm Hưởng Dân Gian', 'https://www.youtube.com/watch?v=RRBxfWjmQJ0', 'https://example.com/poster2', 1, 0, 0, 0, 0, N'Mô tả video Giải trí 2', 1, 1),
(N'Playlist thứ hai về những bản nhạc mang âm hưởng dân gian', 'https://www.youtube.com/watch?v=6D8WzdB10eA', 'https://example.com/poster3', 1, 0, 0, 0, 0, N'Mô tả video Giải trí 3', 1, 1),
(N'Những bài hát mang âm hưởng dân gian', 'https://www.youtube.com/watch?v=CTgCc4rmxA0', 'https://example.com/poster4', 1, 0, 0, 0, 0, N'Mô tả video Giải trí 4', 1, 1),
(N'Tuyển Tập Các Bài Hát Về Tình Yêu Quê Hương, Đất Nước', 'https://www.youtube.com/watch?v=GOMGeUetqlI', 'https://example.com/poster5', 1, 0, 0, 0, 0, N'Mô tả video Giải trí 5', 1, 1),
(N'ƯỚC MƠ CỦA MẸ - CARA lấy đi nước mắt hàng triệu người nghe khi trình diễn hit của Hứa Kim Tuyền', 'https://www.youtube.com/watch?v=f_IKQnztIRU', 'https://example.com/poster6', 1, 0, 0, 0, 0, N'Mô tả video Giải trí 6', 1, 1),
(N'Phá Kén - Trương Thiều Hàm (OST Đấu La Đại Lục)', 'https://www.youtube.com/watch?v=Jfo8QVR03Ig', 'https://example.com/poster7', 1, 0, 0, 0, 0, N'Mô tả video Giải trí 7', 1, 1),
(N'Ảo Ảnh, Tứ Ngã, Tiếng Trăng Rơi, Giá Y Trắng - List nhạc Nhất Khoả Lang Tinh Hứa Lam Tâm', 'https://www.youtube.com/watch?v=_kSw1OQEzfI', 'https://example.com/poster8', 1, 0, 0, 0, 0, N'Mô tả video Giải trí 8', 1, 1),
(N'Huang - Zheng Yu | OST Perfect World', 'https://www.youtube.com/watch?v=IfTp101pNJU', 'https://example.com/poster9', 1, 0, 0, 0, 0, N'Mô tả video Giải trí 9', 1, 1),
(N'Chiến Ca - Coco Lý Mân | OST Đấu La Đại Lục : Song Thần Chi Chiến', 'https://www.youtube.com/watch?v=NbzXRaOVaIU', 'https://example.com/poster10', 1, 0, 0, 0, 0, N'Mô tả video Giải trí 10', 1, 1),

-- Video cho thể loại "Tin tức"
(N'Tin tức 1', 'https://www.youtube.com/watch?v=MFjSVS1o_DA', 'https://example.com/poster11', 2, 0, 0, 0, 0, N'Mô tả video Tin tức 1', 1, 1),
(N'Tin tức 2', 'https://www.youtube.com/watch?v=C2m2N04u3VQ', 'https://example.com/poster12', 2, 0, 0, 0, 0, N'Mô tả video Tin tức 2', 1, 1),
(N'Tin tức 3', 'https://www.youtube.com/watch?v=jBZTWrrXk68', 'https://example.com/poster13', 2, 0, 0, 0, 0, N'Mô tả video Tin tức 3', 1, 1),
(N'Tin tức 4', 'https://www.youtube.com/watch?v=-hoCsgEJkuE', 'https://example.com/poster14', 2, 0, 0, 0, 0, N'Mô tả video Tin tức 4', 1, 1),
(N'Tin tức 5', 'https://www.youtube.com/watch?v=Y-58N3aYvNY', 'https://example.com/poster15', 2, 0, 0, 0, 0, N'Mô tả video Tin tức 5', 1, 1),
(N'Tin tức 6', 'https://www.youtube.com/watch?v=asQsKwgssjI', 'https://example.com/poster16', 2, 0, 0, 0, 0, N'Mô tả video Tin tức 6', 1, 1),
(N'Tin tức 7', 'https://www.youtube.com/watch?v=sF3ADHQ44xg', 'https://example.com/poster17', 2, 0, 0, 0, 0, N'Mô tả video Tin tức 7', 1, 1),
(N'Tin tức 8', 'https://www.youtube.com/watch?v=QFe05yqlBzs', 'https://example.com/poster18', 2, 0, 0, 0, 0, N'Mô tả video Tin tức 8', 1, 1),
(N'Tin tức 9', 'https://www.youtube.com/watch?v=rq3B3I4N-xo', 'https://example.com/poster19', 2, 0, 0, 0, 0, N'Mô tả video Tin tức 9', 1, 1),
(N'Tin tức 10', 'https://www.youtube.com/watch?v=ngLk4abdGBo', 'https://example.com/poster20', 2, 0, 0, 0, 0, N'Mô tả video Tin tức 10', 1, 1),

-- Video cho thể loại "Giáo dục"
(N'Giáo dục 1', 'https://www.youtube.com/watch?v=f7xfiw6iGws', 'https://example.com/poster21', 3, 0, 0, 0, 0, N'Mô tả video Giáo dục 1', 1, 1),
(N'Giáo dục 2', 'https://www.youtube.com/watch?v=9c-yi4vCqZg', 'https://example.com/poster22', 3, 0, 0, 0, 0, N'Mô tả video Giáo dục 2', 1, 1),
(N'Giáo dục 3', 'https://www.youtube.com/watch?v=tTFLMUVXGmo', 'https://example.com/poster23', 3, 0, 0, 0, 0, N'Mô tả video Giáo dục 3', 1, 1),
(N'Giáo dục 4', 'https://www.youtube.com/watch?v=h0ouyRna3p0', 'https://example.com/poster24', 3, 0, 0, 0, 0, N'Mô tả video Giáo dục 4', 1, 1),
(N'Giáo dục 5', 'https://www.youtube.com/watch?v=loR8LIwakaU', 'https://example.com/poster25', 3, 0, 0, 0, 0, N'Mô tả video Giáo dục 5', 1, 1),
(N'Giáo dục 6', 'https://www.youtube.com/watch?v=JtVvqNcpM-4', 'https://example.com/poster26', 3, 0, 0, 0, 0, N'Mô tả video Giáo dục 6', 1, 1),
(N'Giáo dục 7', 'https://www.youtube.com/watch?v=mXrbLTeK5n0', 'https://example.com/poster27', 3, 0, 0, 0, 0, N'Mô tả video Giáo dục 7', 1, 1),
(N'Giáo dục 8', 'https://www.youtube.com/watch?v=FXPH8F_tBbE', 'https://example.com/poster28', 3, 0, 0, 0, 0, N'Mô tả video Giáo dục 8', 1, 1),
(N'Giáo dục 9', 'https://www.youtube.com/watch?v=IZfix5WD8kc', 'https://example.com/poster29', 3, 0, 0, 0, 0, N'Mô tả video Giáo dục 9', 1, 1),
(N'Giáo dục 10', 'https://www.youtube.com/watch?v=EhvmtEN77hE', 'https://example.com/poster30', 3, 0, 0, 0, 0, N'Mô tả video Giáo dục 10', 1, 1),

-- Video cho thể loại "Ẩm thực"
(N'Ẩm thực 1', 'https://www.youtube.com/watch?v=fd3V7xesedk', 'https://example.com/poster31', 4, 0, 0, 0, 0, N'Mô tả video Ẩm thực 1', 1, 1),
(N'Ẩm thực 2', 'https://www.youtube.com/watch?v=uOyjj06GGuE', 'https://example.com/poster32', 4, 0, 0, 0, 0, N'Mô tả video Ẩm thực 2', 1, 1),
(N'Ẩm thực 3', 'https://www.youtube.com/watch?v=Stwau2ND_fo', 'https://example.com/poster33', 4, 0, 0, 0, 0, N'Mô tả video Ẩm thực 3', 1, 1),
(N'Ẩm thực 4', 'https://www.youtube.com/watch?v=WkQrMzwqKv4', 'https://example.com/poster34', 4, 0, 0, 0, 0, N'Mô tả video Ẩm thực 4', 1, 1),
(N'Ẩm thực 5', 'https://www.youtube.com/watch?v=3MLTE9Zqcoo', 'https://example.com/poster35', 4, 0, 0, 0, 0, N'Mô tả video Ẩm thực 5', 1, 1),
(N'Ẩm thực 6', 'https://www.youtube.com/watch?v=P6sTH0NiKN8', 'https://example.com/poster36', 4, 0, 0, 0, 0, N'Mô tả video Ẩm thực 6', 1, 1),
(N'Ẩm thực 7', 'https://www.youtube.com/watch?v=7CrbTroqvMA', 'https://example.com/poster37', 4, 0, 0, 0, 0, N'Mô tả video Ẩm thực 7', 1, 1),
(N'Ẩm thực 8', 'https://www.youtube.com/watch?v=L-NUzyTg3YY', 'https://example.com/poster38', 4, 0, 0, 0, 0, N'Mô tả video Ẩm thực 8', 1, 1),
(N'Ẩm thực 9', 'https://www.youtube.com/watch?v=kRTLK_bEzSc', 'https://example.com/poster39', 4, 0, 0, 0, 0, N'Mô tả video Ẩm thực 9', 1, 1),
(N'Ẩm thực 10', 'https://www.youtube.com/watch?v=0_KIZ5GY7HA', 'https://example.com/poster40', 4, 0, 0, 0, 0, N'Mô tả video Ẩm thực 10', 1, 1),

-- Video cho thể loại "Sức khỏe"
(N'Sức khỏe 1', 'https://www.youtube.com/watch?v=ygr6PNt-k-c', 'https://example.com/poster41', 5, 0, 0, 0, 0, N'Mô tả video Sức khỏe 1', 1, 1),
(N'Sức khỏe 2', 'https://www.youtube.com/watch?v=KyJPwoQsuHk', 'https://example.com/poster42', 5, 0, 0, 0, 0, N'Mô tả video Sức khỏe 2', 1, 1),
(N'Sức khỏe 3', 'https://www.youtube.com/watch?v=ijC1SbOU4hg', 'https://example.com/poster43', 5, 0, 0, 0, 0, N'Mô tả video Sức khỏe 3', 1, 1),
(N'Sức khỏe 4', 'https://www.youtube.com/watch?v=mphe8MgxTWU', 'https://example.com/poster44', 5, 0, 0, 0, 0, N'Mô tả video Sức khỏe 4', 1, 1),
(N'Sức khỏe 5', 'https://www.youtube.com/watch?v=mJuUOM7_dgM', 'https://example.com/poster45', 5, 0, 0, 0, 0, N'Mô tả video Sức khỏe 5', 1, 1),
(N'Sức khỏe 6', 'https://www.youtube.com/watch?v=WScyvNjF8LE', 'https://example.com/poster46', 5, 0, 0, 0, 0, N'Mô tả video Sức khỏe 6', 1, 1),
(N'Sức khỏe 7', 'https://www.youtube.com/watch?v=vMNVBODOFmQ', 'https://example.com/poster47', 5, 0, 0, 0, 0, N'Mô tả video Sức khỏe 7', 1, 1),
(N'Sức khỏe 8', 'https://www.youtube.com/watch?v=n_d9wX2939w', 'https://example.com/poster48', 5, 0, 0, 0, 0, N'Mô tả video Sức khỏe 8', 1, 1),
(N'Sức khỏe 9', 'https://www.youtube.com/watch?v=OCFmfwZv_wQ', 'https://example.com/poster49', 5, 0, 0, 0, 0, N'Mô tả video Sức khỏe 9', 1, 1),
(N'Sức khỏe 10', 'https://www.youtube.com/watch?v=237Gk6Js8Tk', 'https://example.com/poster50', 5, 0, 0, 0, 0, N'Mô tả video Sức khỏe 10', 1, 1),

-- Video cho thể loại "Công nghệ"
(N'Công nghệ 1', 'https://www.youtube.com/watch?v=VF1faGGOPhY', 'https://example.com/poster51', 6, 0, 0, 0, 0, N'Mô tả video Công nghệ 1', 1, 1),
(N'Công nghệ 2', 'https://www.youtube.com/watch?v=eOJmDgEx-w4', 'https://example.com/poster52', 6, 0, 0, 0, 0, N'Mô tả video Công nghệ 2', 1, 1),
(N'Công nghệ 3', 'https://www.youtube.com/watch?v=CPkAm0troww', 'https://example.com/poster53', 6, 0, 0, 0, 0, N'Mô tả video Công nghệ 3', 1, 1),
(N'Công nghệ 4', 'https://www.youtube.com/watch?v=PfXD6JDx-pw', 'https://example.com/poster54', 6, 0, 0, 0, 0, N'Mô tả video Công nghệ 4', 1, 1),
(N'Công nghệ 5', 'https://www.youtube.com/watch?v=DgQHgy7Nmkk', 'https://example.com/poster55', 6, 0, 0, 0, 0, N'Mô tả video Công nghệ 5', 1, 1),
(N'Công nghệ 6', 'https://www.youtube.com/watch?v=BGVdW2tY2Lw', 'https://example.com/poster56', 6, 0, 0, 0, 0, N'Mô tả video Công nghệ 6', 1, 1),
(N'Công nghệ 7', 'https://www.youtube.com/watch?v=uQnmfEka3vw', 'https://example.com/poster57', 6, 0, 0, 0, 0, N'Mô tả video Công nghệ 7', 1, 1),
(N'Công nghệ 8', 'https://www.youtube.com/watch?v=BkPgvXWrPeY', 'https://example.com/poster58', 6, 0, 0, 0, 0, N'Mô tả video Công nghệ 8', 1, 1),
(N'Công nghệ 9', 'https://www.youtube.com/watch?v=9A5ct4P9ZaY', 'https://example.com/poster59', 6, 0, 0, 0, 0, N'Mô tả video Công nghệ 9', 1, 1),
(N'Công nghệ 10', 'https://www.youtube.com/watch?v=fRKviUgMP4o', 'https://example.com/poster60', 6, 0, 0, 0, 0, N'Mô tả video Công nghệ 10', 1, 1),

-- Video cho thể loại "Thể thao"
(N'Thể thao 1', 'https://www.youtube.com/watch?v=MJPIMQQwGh8', 'https://example.com/poster61', 7, 0, 0, 0, 0, N'Mô tả video Thể thao 1', 1, 1),
(N'Thể thao 2', 'https://www.youtube.com/watch?v=p73QIl4GvJY', 'https://example.com/poster62', 7, 0, 0, 0, 0, N'Mô tả video Thể thao 2', 1, 1),
(N'Thể thao 3', 'https://www.youtube.com/watch?v=7a_jSdPm17E', 'https://example.com/poster63', 7, 0, 0, 0, 0, N'Mô tả video Thể thao 3', 1, 1),
(N'Thể thao 4', 'https://www.youtube.com/watch?v=xlicdtWRNx0', 'https://example.com/poster64', 7, 0, 0, 0, 0, N'Mô tả video Thể thao 4', 1, 1),
(N'Thể thao 5', 'https://www.youtube.com/watch?v=AAkdZcxDo40', 'https://example.com/poster65', 7, 0, 0, 0, 0, N'Mô tả video Thể thao 5', 1, 1),
(N'Thể thao 6', 'https://www.youtube.com/watch?v=1T3kp_IkUus', 'https://example.com/poster66', 7, 0, 0, 0, 0, N'Mô tả video Thể thao 6', 1, 1),
(N'Thể thao 7', 'https://www.youtube.com/watch?v=H1GxisiNiBM', 'https://example.com/poster67', 7, 0, 0, 0, 0, N'Mô tả video Thể thao 7', 1, 1),
(N'Thể thao 8', 'https://www.youtube.com/watch?v=BbmffyMcORs', 'https://example.com/poster68', 7, 0, 0, 0, 0, N'Mô tả video Thể thao 8', 1, 1),
(N'Thể thao 9', 'https://www.youtube.com/watch?v=-NOeb6HK2Rg', 'https://example.com/poster69', 7, 0, 0, 0, 0, N'Mô tả video Thể thao 9', 1, 1),
(N'Thể thao 10', 'https://www.youtube.com/watch?v=CyAQqTscV0A', 'https://example.com/poster70', 7, 0, 0, 0, 0, N'Mô tả video Thể thao 10', 1, 1);
