#include <cuda.h>
#include <cuda_runtime.h>
#include "common.h"
#include "efficient.h"

namespace StreamCompaction {
    namespace Efficient {
        using StreamCompaction::Common::PerformanceTimer;
        PerformanceTimer& timer()
        {
            static PerformanceTimer timer;
            return timer;
        }


		__global__  void scanInternal(int n, int *odata, const int *idata)
		{
			// TODO


		}
        /**
         * Performs prefix-sum (aka scan) on idata, storing the result into odata.
         */
		void scan(int n, int *odata, const int *idata)
		{
			timer().startGpuTimer();

			// Allocate GPU memory and write in.
			int *in, *out;
			cudaMalloc(&in, n * sizeof(int));
			cudaMalloc(&out, n * sizeof(int));
			cudaMemcpy(in, idata, n * sizeof(int), cudaMemcpyHostToDevice);


			const int blockSize = 128;
			int blockNum = (n + blockSize - 1) / blockSize;
			scanInternal << <blockNum, blockSize >> > (n, odata, idata);
			// Write the data back to host memory.
			cudaMemcpy(odata, out, n * sizeof(int), cudaMemcpyDeviceToHost);
			cudaFree(in);
			cudaFree(out);

			timer().endGpuTimer();
		}

        /**
         * Performs stream compaction on idata, storing the result into odata.
         * All zeroes are discarded.
         *
         * @param n      The number of elements in idata.
         * @param odata  The array into which to store elements.
         * @param idata  The array of elements to compact.
         * @returns      The number of elements remaining after compaction.
         */
        int compact(int n, int *odata, const int *idata) {
            timer().startGpuTimer();
            // TODO
            timer().endGpuTimer();
            return -1;
        }
    }
}
