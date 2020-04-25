using System.IO;
using System.Threading.Tasks;

namespace IveArrived.Services.File
{
    public interface IFileService
    {
        Task<string> Publish(Stream fileStream);
    }
}