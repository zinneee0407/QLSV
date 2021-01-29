using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SVModel.DAO
{
    public class ChuyennganhDAO
    {
        BaiTH5Entities db;
        public ChuyennganhDAO(BaiTH5Entities _dbContext)
        {
            db = _dbContext;
        }


        public List<tbl_chuyennganhEntity> getALL()
        {
            var query = (from obj in db.tbl_chuyennganh
                         select new tbl_chuyennganhEntity
                         {
                             Macn = obj.Macn,
                             Tencn = obj.Tencn,
                             Ghichu = obj.Ghichu
                         });
            return query.OrderBy(p => p.Macn).ToList();
        }
    }
    
}
