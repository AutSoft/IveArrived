using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;

namespace IveArrived.Services.File
{
    public class FileService: IFileService
    {
        public async Task<string> Publish(Stream fileStream)
        {
            var path = Guid.NewGuid().ToString().Insert(2, "/");

            using (var stream = System.IO.File.Create("wwwroot/" + path))
            {
                await fileStream.CopyToAsync(stream);
            }

            return "~/" + path;
        }
    }
}
