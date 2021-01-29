using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SVModel.DAO
{
    public class SinhvienDAO
    {
        BaiTH5Entities db;
        public SinhvienDAO(BaiTH5Entities _dbContext)
        {
            db = _dbContext;
        }

        public List<tbl_sinhvienEntity> getPage(int pageNum, int pageSize)
        {
            int excludedRows = (pageNum - 1) * pageSize;
            var query = (from sv in db.tbl_sinhvien
                          join cn in db.tbl_chuyennganh on sv.Chuyennganh equals cn.Macn
                          join kh in db.tbl_khoahoc on sv.Khoa equals kh.Makh
                          select new tbl_sinhvienEntity
                          {
                              Masv = sv.Masv,
                              TenSV = sv.TenSV,
                              Gioittinh = sv.Gioittinh,
                              Namsinh = sv.Namsinh,
                              Chuyennganh = cn.Tencn,
                              Khoa = kh.Tenkhoa,
                              Email = sv.Email,
                              Diachi = sv.Diachi,
                              Dienthoai = sv.Dienthoai,
                              Totnghiep = sv.Totnghiep
                          });
            return query.OrderBy(p => p.Masv).Skip(excludedRows).Take(pageSize).ToList();
        }

        public List<tbl_sinhvienEntity> getALL()
        {
            var query = (from sv in db.tbl_sinhvien
                         join cn in db.tbl_chuyennganh on sv.Chuyennganh equals cn.Macn
                         join kh in db.tbl_khoahoc on sv.Khoa equals kh.Makh
                         select new tbl_sinhvienEntity
                         {
                             Masv = sv.Masv,
                             TenSV = sv.TenSV,
                             Gioittinh = sv.Gioittinh,
                             Namsinh = sv.Namsinh,
                             Chuyennganh = cn.Tencn,
                             Khoa = kh.Tenkhoa,
                             Email = sv.Email,
                             Diachi = sv.Diachi,
                             Dienthoai = sv.Dienthoai,
                             Totnghiep = sv.Totnghiep
                         });
            return query.OrderBy(p => p.Masv).ToList();
        }

        public tbl_sinhvien getbyId(int id)
        {
            return db.tbl_sinhvien.Where(p => p.Masv == id).FirstOrDefault();
        }

        public bool AddStudent(tbl_sinhvien sv)
        {
            db.tbl_sinhvien.Add(sv);
            db.SaveChanges();
            return true;
        }

        public bool DeleteItem(int id)
        {
            tbl_sinhvien sv = db.tbl_sinhvien.SingleOrDefault(p => p.Masv == id);
            db.tbl_sinhvien.Remove(sv);
            db.SaveChanges();
            return true;
        }

        public int Save()
        {
            return db.SaveChanges();
        }

        public tbl_sinhvien getbyEmail(string email)
        {
            return db.tbl_sinhvien.Where(p => p.Email == email).FirstOrDefault();
        }

        public tbl_sinhvien getbyPhone(string phone)
        {
            return db.tbl_sinhvien.Where(p => p.Dienthoai == phone).FirstOrDefault();
        }

        public bool checkSV(int msv)
        {
            return db.tbl_sinhvien.FirstOrDefault(u => u.Masv.Equals(msv)) == null ? true : false;
        }
        public bool checkSV(string email)
        {
            return db.tbl_sinhvien.FirstOrDefault(u => u.Email.Equals(email)) == null ? true : false;
        }
        public bool checkSDT(string phone)
        {
            return db.tbl_sinhvien.FirstOrDefault(u => u.Dienthoai.Equals(phone)) == null ? true : false;
        }

        public List<tbl_sinhvienEntity> search(string searchValue, string cnValue , int pageNum, int pageSize)
        {
            int excludedRows = (pageNum - 1) * pageSize;
            var query = (from sv in db.tbl_sinhvien
                         join cn in db.tbl_chuyennganh on sv.Chuyennganh equals cn.Macn
                         join kh in db.tbl_khoahoc on sv.Khoa equals kh.Makh
                         select new tbl_sinhvienEntity
                         {
                             Masv = sv.Masv,
                             TenSV = sv.TenSV,
                             Gioittinh = sv.Gioittinh,
                             Namsinh = sv.Namsinh,
                             Chuyennganh = cn.Tencn,
                             Khoa = kh.Tenkhoa,
                             Email = sv.Email,
                             Diachi = sv.Diachi,
                             Dienthoai = sv.Dienthoai,
                             Totnghiep = sv.Totnghiep
                         });
            return query.Where(p => (p.TenSV.Contains(searchValue) || p.Masv.ToString().Contains(searchValue)) && p.Chuyennganh.Contains(cnValue) )
                .OrderBy(p => p.Masv)
                .Skip(excludedRows)
                .Take(pageSize)
                .ToList();
        }

        public List<tbl_sinhvienEntity> search(string searchValue, string cnValue)
        {
            var query = (from sv in db.tbl_sinhvien
                         join cn in db.tbl_chuyennganh on sv.Chuyennganh equals cn.Macn
                         join kh in db.tbl_khoahoc on sv.Khoa equals kh.Makh
                         select new tbl_sinhvienEntity
                         {
                             Masv = sv.Masv,
                             TenSV = sv.TenSV,
                             Gioittinh = sv.Gioittinh,
                             Namsinh = sv.Namsinh,
                             Chuyennganh = cn.Tencn,
                             Khoa = kh.Tenkhoa,
                             Email = sv.Email,
                             Diachi = sv.Diachi,
                             Dienthoai = sv.Dienthoai,
                             Totnghiep = sv.Totnghiep
                         });
            return query.Where(p => (p.TenSV.Contains(searchValue) || p.Masv.ToString().Contains(searchValue)) && p.Chuyennganh.Contains(cnValue))
                .OrderBy(p => p.Masv)
                .ToList();
        }
    }
}
