--1)Tüm tablolardaki verileri ayrý ayrý görüntüleyiniz.
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
--2)kullanici tablosunda bulunan kullanýcýlarýn adsoyad, cinsiyet ve doðum tarihlerini görüntüleyiniz
select adsoyad,cinsiyet,dogumTarihi from dbo.kullanici
--3)urun tablosunda fiyatý 200 ve üzerinde olan ürünlerin bilgilerini görüntüleyiniz
select * from dbo.urun where fiyat>=200
--4)kullanici tablosunda ilk adý ahmet olan kullanýcýlarýn bilgilerini listeleyiniz.
select * from dbo.kullanici where adSoyad like 'Ahmet%'
--5)urun tablosunda urunAdi alanýnda içerisinde pirinç kelimesi geçen ürünleri listeleyiniz
select * from dbo.urun where urunAdi like '%pirinç%'
--6)urun tablosunda alt kategori numarasý 13 olan ürünlerden 30 TL ve üzerinde olanlarýn bilgilerini görüntüleyiniz
select * from dbo.urun where altkategorino = 13 and fiyat >= 30
--7)urun tablosunda alt kategori numarasý 24 ve 25 olanlarý birlikte görüntüleyiniz
select * from dbo.urun where altkategorino = 24 or altkategorino = 25
--8)hangi ürünler sipariþ edilmiþtir ürün numaralarýný gösteriniz (her ürün numarasý bir kez gösterilmelidir)
select distinct urunNo from dbo.siparisDetay
--9)kullanýcýlar arasýnda doðum tarihi 1999 olan erkekleri gösteriniz
select * from dbo.kullanici where dogumTarihi like '1999%' and cinsiyet = 'E'
--10)sipariþ tablosundaki kayýtlarý toplam tutara göre azalan sýralamada sýralayýnýz
select * from dbo.siparis order By toplamTutar desc
--11)ürünleri pahalýdan ucuza sýralayarak gösteriniz
select urunAdi,fiyat from dbo.urun order by fiyat desc
--12)urun tablosundaki urunAdi ve fiyat alanlarýný Ürün Adý ve Ürün Fiyatý olarak görünecek þekilde görüntüleyiniz
select urunAdi as [Ürün Adý],fiyat as [Ürün Fiyatý] from dbo.urun
--13)ortalama sipariþ tutarý nedir. sadece bu rakamý ondalýklý olarak görüntüleyiniz
select avg(toplamTutar)  as [Ortalama Sipariþ Tutarý] from dbo.siparis
--14)urun tablosundaki tum alanlarla birlikte fiyat deðerine %18 kdv ekleyerek kdvdahil isimli alanda gösteriniz.
select *,fiyat+fiyat*0.18 as [KDV Dahil] from dbo.urun
--15)kullanýcýlarýn eposta alanlarýnda bulunan kullanýcý adlarýný (@ iþaretinin solundaki kýsým) kAdi isimli alanda gösteriniz.
select substring(eposta,0,charindex('@',eposta)) as [kAdi] from dbo.kullanici
--16)eposta adresindeki kullanýcý adý kýsmý(@ iþaretinin solundaki kýsým) ile tablodaki kullanýcýAdi alanýný karþýlaþtýrarak farklý olan kayýtlarý gösteriniz
select substring(eposta,0,charindex('@',eposta)) as [Farklý Olanlar] from dbo.kullanici
EXCEPT
select kullaniciAdi from dbo.kullanici
--17)kullanici tablosunda tel1 veya tel2 alanýndaki telefonlardan 505 kodunu kullanan kullanýcýlarý listeletiniz
select tel1,tel2 from dbo.kullanici where tel1 like '(505)%' and tel2 like '(505)%'
--18)1 nisanda doðmuþ kullanýcýlarý listeleyiniz
select * from dbo.kullanici where dogumTarihi like '%-04-01'
--19)kullanýcýlarýn bilgileri ile birlikte Yaþ alanýnda yaþlarýný görüntüleyiniz
select *,datediff(year,dogumTarihi,getdate()) as [Yaþ] from dbo.kullanici
--20)yaþý 36 olan kullanýcýlarýn bilgilerini gösteriniz
select *,datediff(year,dogumTarihi,getdate()) as [Yaþ] from dbo.kullanici where datediff(year,dogumTarihi,getdate()) = 36
--21)urun tablosunda alt kategori numarasý 48 olan ürünleri ucuzdan pahalýya sýralayýnýz
select * from dbo.urun where altkategorino = 48 order by fiyat asc
--22)urun tablosunda ürün adý 7 karakterden oluþan ürünleri listeleyiniz
select * from dbo.urun where len(urunAdi) = 7
--23)kullanýcý tablosunda adsoyad uzunluðunu göstererek bilgileri bu uzunluða göre azalan sýralamada sýralayýnýz.
select adSoyad,len(adSoyad) as [Ad Soyad Uzunluðu] from dbo.kullanici order by len(adSoyad) desc
--24)urun tablosunda 10 nolu alt kategoriye ait urunlerin ortalama fiyatýný virgulden sonra 2 basamak olacak þekilde gösteriniz
select cast(avg(fiyat) as decimal(15,2)) as [Kategori Numarasý 10 Olanlarýn Fiyat Ortalamasý] from dbo.urun where altkategorino = 10
--25)en yüksek sipariþ tutarýný gösteriniz (tek bir sayý gösterilecek)
select max(toplamTutar) as [En Yüksek Sipariþ Tutarý] from dbo.siparis 