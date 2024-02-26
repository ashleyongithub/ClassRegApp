USE [master]
GO

DECLARE @DefaultFile varchar(500);
DECLARE @DefaultLog varchar(500);

SELECT @DefaultFile = CONVERT(varchar(300),SERVERPROPERTY('instancedefaultdatapath')) + 'ProgrammingTest.mdf'
SELECT @DefaultLog = CONVERT(varchar(300),SERVERPROPERTY('instancedefaultlogpath')) + 'ProgrammingTest_log.ldf'

DECLARE @CreateDB varchar(max) = 'CREATE DATABASE DevelopmentTest CONTAINMENT = NONE ON  PRIMARY ( NAME = N''ProgrammingTest'', FILENAME = N'''+ @DefaultFile +''', SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB ) LOG ON ( NAME = N''ProgrammingTest_log'', FILENAME = N'''+ @DefaultLog +''' , SIZE = 14336KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)'


EXECUTE(@CreateDB)

ALTER DATABASE [DevelopmentTest] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DevelopmentTest].[dbo].[sp_fulltext_database] @action = 'disable'
end
GO
ALTER DATABASE [DevelopmentTest] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DevelopmentTest] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DevelopmentTest] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DevelopmentTest] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DevelopmentTest] SET ARITHABORT OFF 
GO
ALTER DATABASE [DevelopmentTest] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [DevelopmentTest] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DevelopmentTest] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DevelopmentTest] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DevelopmentTest] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DevelopmentTest] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DevelopmentTest] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DevelopmentTest] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DevelopmentTest] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DevelopmentTest] SET  DISABLE_BROKER 
GO
ALTER DATABASE [DevelopmentTest] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DevelopmentTest] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DevelopmentTest] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DevelopmentTest] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [DevelopmentTest] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DevelopmentTest] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [DevelopmentTest] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [DevelopmentTest] SET RECOVERY FULL 
GO
ALTER DATABASE [DevelopmentTest] SET  MULTI_USER 
GO
ALTER DATABASE [DevelopmentTest] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DevelopmentTest] SET DB_CHAINING OFF 
GO
ALTER DATABASE [DevelopmentTest] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [DevelopmentTest] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [DevelopmentTest] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'DevelopmentTest', N'ON'
GO
ALTER DATABASE [DevelopmentTest] SET QUERY_STORE = OFF
GO
USE [DevelopmentTest]
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [DevelopmentTest]
GO
/****** Object:  Table [dbo].[Class]    Script Date: 01/11/2019 15:39:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Class](
	[Class_ID] [int] IDENTITY(1,1) NOT NULL,
	[ClassName] [varchar](100) NOT NULL,
	[Teacher_ID] [int] NOT NULL,
 CONSTRAINT [PK_Class] PRIMARY KEY CLUSTERED 
(
	[Class_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ClassRegistration]    Script Date: 01/11/2019 15:39:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClassRegistration](
	[Student_ID] [int] NOT NULL,
	[Class_ID] [int] NOT NULL,
	[HasPaidFees] [bit] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Student]    Script Date: 01/11/2019 15:39:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Student](
	[Student_ID] [int] IDENTITY(1,1) NOT NULL,
	[StudentName] [varchar](150) NOT NULL,
 CONSTRAINT [PK_Pupil] PRIMARY KEY CLUSTERED 
(
	[Student_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Teacher]    Script Date: 01/11/2019 15:39:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Teacher](
	[Teacher_ID] [int] IDENTITY(1,1) NOT NULL,
	[TeacherName] [varchar](150) NOT NULL,
 CONSTRAINT [PK_Teacher] PRIMARY KEY CLUSTERED 
(
	[Teacher_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[Class]  WITH NOCHECK ADD  CONSTRAINT [FK_Class_Teacher] FOREIGN KEY([Teacher_ID])
REFERENCES [dbo].[Teacher] ([Teacher_ID])
GO
ALTER TABLE [dbo].[Class] CHECK CONSTRAINT [FK_Class_Teacher]
GO
ALTER TABLE [dbo].[ClassRegistration]  WITH NOCHECK ADD  CONSTRAINT [FK_ClassRegistration_Class] FOREIGN KEY([Class_ID])
REFERENCES [dbo].[Class] ([Class_ID])
GO
ALTER TABLE [dbo].[ClassRegistration] CHECK CONSTRAINT [FK_ClassRegistration_Class]
GO
ALTER TABLE [dbo].[ClassRegistration]  WITH NOCHECK ADD  CONSTRAINT [FK_ClassRegistration_Pupil] FOREIGN KEY([Student_ID])
REFERENCES [dbo].[Student] ([Student_ID])
GO
ALTER TABLE [dbo].[ClassRegistration] CHECK CONSTRAINT [FK_ClassRegistration_Pupil]
GO
USE [master]
GO
ALTER DATABASE [DevelopmentTest] SET  READ_WRITE 
GO

USE [master]
GO
CREATE LOGIN [DevelopmentTest] WITH PASSWORD=N'd3vel0pm3ntT3st', DEFAULT_DATABASE=[master], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO
use [DevelopmentTest];
GO
use [master];
GO
USE [DevelopmentTest]
GO
CREATE USER [DevelopmentTest] FOR LOGIN [DevelopmentTest]
GO
USE [DevelopmentTest]
GO
ALTER ROLE [db_owner] ADD MEMBER [DevelopmentTest]
GO


USE [DevelopmentTest]
GO
SET IDENTITY_INSERT [dbo].[Teacher] ON 

GO
INSERT [dbo].[Teacher] ([Teacher_ID], [TeacherName]) VALUES (1, N'Donald Duck')
GO
INSERT [dbo].[Teacher] ([Teacher_ID], [TeacherName]) VALUES (2, N'Mickey Mouse')
GO
INSERT [dbo].[Teacher] ([Teacher_ID], [TeacherName]) VALUES (3, N'Betty Boop')
GO
INSERT [dbo].[Teacher] ([Teacher_ID], [TeacherName]) VALUES (4, N'Wile E. Coyote')
GO
INSERT [dbo].[Teacher] ([Teacher_ID], [TeacherName]) VALUES (5, N'Road Runner')
GO
SET IDENTITY_INSERT [dbo].[Teacher] OFF
GO
SET IDENTITY_INSERT [dbo].[Class] ON 

GO
INSERT [dbo].[Class] ([Class_ID], [ClassName], [Teacher_ID]) VALUES (5, N'Anger Management', 1)
GO
INSERT [dbo].[Class] ([Class_ID], [ClassName], [Teacher_ID]) VALUES (6, N'ASP.NET and XML Web Services', 2)
GO
INSERT [dbo].[Class] ([Class_ID], [ClassName], [Teacher_ID]) VALUES (7, N'Coyote Antagonism 101', 5)
GO
INSERT [dbo].[Class] ([Class_ID], [ClassName], [Teacher_ID]) VALUES (8, N'Advanced COM', 2)
GO
SET IDENTITY_INSERT [dbo].[Class] OFF
GO
SET IDENTITY_INSERT [dbo].[Student] ON 

GO
INSERT [dbo].[Student] ([Student_ID], [StudentName]) VALUES (1, N'John Doe')
GO
INSERT [dbo].[Student] ([Student_ID], [StudentName]) VALUES (2, N'James Smith')
GO
INSERT [dbo].[Student] ([Student_ID], [StudentName]) VALUES (3, N'Jane Jones')
GO
INSERT [dbo].[Student] ([Student_ID], [StudentName]) VALUES (4, N'Alistair Bell')
GO
INSERT [dbo].[Student] ([Student_ID], [StudentName]) VALUES (5, N'Daniel Birch')
GO
INSERT [dbo].[Student] ([Student_ID], [StudentName]) VALUES (6, N'Adam Johnson')
GO
INSERT [dbo].[Student] ([Student_ID], [StudentName]) VALUES (7, N'Peter Savage')
GO
INSERT [dbo].[Student] ([Student_ID], [StudentName]) VALUES (8, N'Tom Dickinson')
GO
INSERT [dbo].[Student] ([Student_ID], [StudentName]) VALUES (9, N'Rachael Clarke')
GO
SET IDENTITY_INSERT [dbo].[Student] OFF
GO
INSERT [dbo].[ClassRegistration] ([Student_ID], [Class_ID], [HasPaidFees]) VALUES (1, 5, 1)
GO
INSERT [dbo].[ClassRegistration] ([Student_ID], [Class_ID], [HasPaidFees]) VALUES (2, 5, 1)
GO
INSERT [dbo].[ClassRegistration] ([Student_ID], [Class_ID], [HasPaidFees]) VALUES (3, 5, 1)
GO
INSERT [dbo].[ClassRegistration] ([Student_ID], [Class_ID], [HasPaidFees]) VALUES (4, 5, 1)
GO
INSERT [dbo].[ClassRegistration] ([Student_ID], [Class_ID], [HasPaidFees]) VALUES (5, 5, 1)
GO
INSERT [dbo].[ClassRegistration] ([Student_ID], [Class_ID], [HasPaidFees]) VALUES (6, 5, 1)
GO
INSERT [dbo].[ClassRegistration] ([Student_ID], [Class_ID], [HasPaidFees]) VALUES (7, 5, 1)
GO
INSERT [dbo].[ClassRegistration] ([Student_ID], [Class_ID], [HasPaidFees]) VALUES (8, 5, 1)
GO
INSERT [dbo].[ClassRegistration] ([Student_ID], [Class_ID], [HasPaidFees]) VALUES (9, 5, 1)
GO
INSERT [dbo].[ClassRegistration] ([Student_ID], [Class_ID], [HasPaidFees]) VALUES (1, 6, 1)
GO
INSERT [dbo].[ClassRegistration] ([Student_ID], [Class_ID], [HasPaidFees]) VALUES (2, 6, 1)
GO
INSERT [dbo].[ClassRegistration] ([Student_ID], [Class_ID], [HasPaidFees]) VALUES (3, 6, 1)
GO
INSERT [dbo].[ClassRegistration] ([Student_ID], [Class_ID], [HasPaidFees]) VALUES (4, 6, 1)
GO
INSERT [dbo].[ClassRegistration] ([Student_ID], [Class_ID], [HasPaidFees]) VALUES (5, 6, 1)
GO
INSERT [dbo].[ClassRegistration] ([Student_ID], [Class_ID], [HasPaidFees]) VALUES (6, 6, 0)
GO
INSERT [dbo].[ClassRegistration] ([Student_ID], [Class_ID], [HasPaidFees]) VALUES (7, 6, 0)
GO
INSERT [dbo].[ClassRegistration] ([Student_ID], [Class_ID], [HasPaidFees]) VALUES (8, 6, 0)
GO
INSERT [dbo].[ClassRegistration] ([Student_ID], [Class_ID], [HasPaidFees]) VALUES (9, 6, 0)
GO
INSERT [dbo].[ClassRegistration] ([Student_ID], [Class_ID], [HasPaidFees]) VALUES (9, 6, 1)
GO
INSERT [dbo].[ClassRegistration] ([Student_ID], [Class_ID], [HasPaidFees]) VALUES (9, 7, 1)
GO
INSERT [dbo].[ClassRegistration] ([Student_ID], [Class_ID], [HasPaidFees]) VALUES (8, 7, 0)
GO
INSERT [dbo].[ClassRegistration] ([Student_ID], [Class_ID], [HasPaidFees]) VALUES (7, 7, 1)
GO
INSERT [dbo].[ClassRegistration] ([Student_ID], [Class_ID], [HasPaidFees]) VALUES (6, 7, 0)
GO

