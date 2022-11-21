--1)T�m tablolardaki verileri ayr� ayr� g�r�nt�leyiniz.
select * from dbo.adres
select * from dbo.fatura
select * from dbo.faturaDetay
select * from dbo.ilce
select * from dbo.kullanici
select * from dbo.sehir
select * from dbo.sepet
select * from dbo.siparis
select * from dbo.siparisDetay
select * from dbo.sipDurum
select * from dbo.urun
select * from dbo.urunAltKateg
select * from dbo.urunKateg
--2)kullanici tablosunda bulunan kullan�c�lar�n adsoyad, cinsiyet ve do�um tarihlerini g�r�nt�leyiniz
select adsoyad,cinsiyet,dogumTarihi from dbo.kullanici
--3)urun tablosunda fiyat� 200 ve �zerinde olan �r�nlerin bilgilerini g�r�nt�leyiniz
select * from dbo.urun where fiyat>=200
--4)kullanici tablosunda ilk ad� ahmet olan kullan�c�lar�n bilgilerini listeleyiniz.
select * from dbo.kullanici where adSoyad like 'Ahmet%'
--5)urun tablosunda urunAdi alan�nda i�erisinde pirin� kelimesi ge�en �r�nleri listeleyiniz
select * from dbo.urun where urunAdi like '%pirin�%'
--6)urun tablosunda alt kategori numaras� 13 olan �r�nlerden 30 TL ve �zerinde olanlar�n bilgilerini g�r�nt�leyiniz
select * from dbo.urun where altkategorino = 13 and fiyat >= 30
--7)urun tablosunda alt kategori numaras� 24 ve 25 olanlar� birlikte g�r�nt�leyiniz
select * from dbo.urun where altkategorino = 24 or altkategorino = 25
--8)hangi �r�nler sipari� edilmi�tir �r�n numaralar�n� g�steriniz (her �r�n numaras� bir kez g�sterilmelidir)
select distinct urunNo from dbo.siparisDetay
--9)kullan�c�lar aras�nda do�um tarihi 1999 olan erkekleri g�steriniz
select * from dbo.kullanici where dogumTarihi like '1999%' and cinsiyet = 'E'
--10)sipari� tablosundaki kay�tlar� toplam tutara g�re azalan s�ralamada s�ralay�n�z
select * from dbo.siparis order By toplamTutar desc
--11)�r�nleri pahal�dan ucuza s�ralayarak g�steriniz
select urunAdi,fiyat from dbo.urun order by fiyat desc
--12)urun tablosundaki urunAdi ve fiyat alanlar�n� �r�n Ad� ve �r�n Fiyat� olarak g�r�necek �ekilde g�r�nt�leyiniz
select urunAdi as [�r�n Ad�],fiyat as [�r�n Fiyat�] from dbo.urun
--13)ortalama sipari� tutar� nedir. sadece bu rakam� ondal�kl� olarak g�r�nt�leyiniz
select avg(toplamTutar)  as [Ortalama Sipari� Tutar�] from dbo.siparis
--14)urun tablosundaki tum alanlarla birlikte fiyat de�erine %18 kdv ekleyerek kdvdahil isimli alanda g�steriniz.
select *,fiyat+fiyat*0.18 as [KDV Dahil] from dbo.urun
--15)kullan�c�lar�n eposta alanlar�nda bulunan kullan�c� adlar�n� (@ i�aretinin solundaki k�s�m) kAdi isimli alanda g�steriniz.
select substring(eposta,0,charindex('@',eposta)) as [kAdi] from dbo.kullanici
--16)eposta adresindeki kullan�c� ad� k�sm�(@ i�aretinin solundaki k�s�m) ile tablodaki kullan�c�Adi alan�n� kar��la�t�rarak farkl� olan kay�tlar� g�steriniz
select substring(eposta,0,charindex('@',eposta)) as [Farkl� Olanlar] from dbo.kullanici
EXCEPT
select kullaniciAdi from dbo.kullanici
--17)kullanici tablosunda tel1 veya tel2 alan�ndaki telefonlardan 505 kodunu kullanan kullan�c�lar� listeletiniz
select tel1,tel2 from dbo.kullanici where tel1 like '(505)%' and tel2 like '(505)%'
--18)1 nisanda do�mu� kullan�c�lar� listeleyiniz
select * from dbo.kullanici where dogumTarihi like '%-04-01'
--19)kullan�c�lar�n bilgileri ile birlikte Ya� alan�nda ya�lar�n� g�r�nt�leyiniz
select *,datediff(year,dogumTarihi,getdate()) as [Ya�] from dbo.kullanici
--20)ya�� 36 olan kullan�c�lar�n bilgilerini g�steriniz
select *,datediff(year,dogumTarihi,getdate()) as [Ya�] from dbo.kullanici where datediff(year,dogumTarihi,getdate()) = 36
--21)urun tablosunda alt kategori numaras� 48 olan �r�nleri ucuzdan pahal�ya s�ralay�n�z
select * from dbo.urun where altkategorino = 48 order by fiyat asc
--22)urun tablosunda �r�n ad� 7 karakterden olu�an �r�nleri listeleyiniz
select * from dbo.urun where len(urunAdi) = 7
--23)kullan�c� tablosunda adsoyad uzunlu�unu g�stererek bilgileri bu uzunlu�a g�re azalan s�ralamada s�ralay�n�z.
select adSoyad,len(adSoyad) as [Ad Soyad Uzunlu�u] from dbo.kullanici order by len(adSoyad) desc
--24)urun tablosunda 10 nolu alt kategoriye ait urunlerin ortalama fiyat�n� virgulden sonra 2 basamak olacak �ekilde g�steriniz
select cast(avg(fiyat) as decimal(15,2)) as [Kategori Numaras� 10 Olanlar�n Fiyat Ortalamas�] from dbo.urun where altkategorino = 10
--25)en y�ksek sipari� tutar�n� g�steriniz (tek bir say� g�sterilecek)
select max(toplamTutar) as [En Y�ksek Sipari� Tutar�] from dbo.siparis 