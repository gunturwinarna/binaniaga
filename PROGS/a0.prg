csql="select * from user where userid=?defauserid"
lcek=SQLEXEC(oODBC,csql,"SMT")
_nogroup  = ALLTRIM(namagroup)
USE
csql="select * from user_group where md5(id)=?_nogroup"
lcek=SQLEXEC(oODBC,csql,"SMT")
mNamagroup=namagroup
MESSAGEBOX(mNamagroup)