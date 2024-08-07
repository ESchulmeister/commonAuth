using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DTB.Authentication
{
    public interface IApplication
    {
        int ID { get; set; }
        string Name { get; set; }
    }
}
