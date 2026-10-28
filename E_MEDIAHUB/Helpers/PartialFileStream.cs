namespace E_MEDIAHUB.Helpers
{
    public class PartialFileStream : Stream
    {
        private readonly FileStream _fileStream;
        private readonly long _start;
        private readonly long _length;
        private long _position;
        private readonly int _bufferSize;

        public PartialFileStream(string filePath, long start, long length, int bufferSize = 65536)
        {
            // CORRECTION: Ajouter FileOptions.Asynchronous
            _fileStream = new FileStream(filePath,
                FileMode.Open,
                FileAccess.Read,
                FileShare.Read,
                bufferSize,
                FileOptions.Asynchronous | FileOptions.SequentialScan); // ← CRITIQUE

            _start = start;
            _length = length;
            _bufferSize = bufferSize;
            _fileStream.Seek(start, SeekOrigin.Begin);
        }

        public override async Task<int> ReadAsync(byte[] buffer, int offset, int count, CancellationToken cancellationToken)
        {
            long remaining = _length - _position;
            if (remaining <= 0) return 0;

            
            int bytesToRead = (int)Math.Min(count, remaining);
            int read = await _fileStream.ReadAsync(buffer, offset, bytesToRead, cancellationToken);

            if (read == 0) return 0; // Fin de fichier

            _position += read;
            return read;
        }

        public override int Read(byte[] buffer, int offset, int count)
        {
            long remaining = _length - _position;
            if (remaining <= 0) return 0;

            int bytesToRead = (int)Math.Min(count, remaining);
            int read = _fileStream.Read(buffer, offset, bytesToRead);
            if (read == 0) return 0; // Fin de fichier
            _position += read;
            return read;
        }

        // Autres membres requis (CanRead, CanSeek, etc.)
        public override bool CanRead => true;
        public override bool CanSeek => false;
        public override bool CanWrite => false;
        public override long Length => _length;

        public override long Position
        {
            get => _position;
            set => throw new NotSupportedException();
        }

        public override long Seek(long offset, SeekOrigin origin) => throw new NotSupportedException();
        public override void SetLength(long value) => throw new NotSupportedException();
        public override void Write(byte[] buffer, int offset, int count) => throw new NotSupportedException();
        public override void Flush() { }

        protected override void Dispose(bool disposing)
        {
            _fileStream?.Dispose();
            base.Dispose(disposing);
        }
    }


}
