sealed class ProofUploadState {
  const ProofUploadState();
}

class ProofUploadInitial extends ProofUploadState {
  const ProofUploadInitial();
}

class ProofUploadLoading extends ProofUploadState {
  const ProofUploadLoading();
}

class ProofUploadSuccess extends ProofUploadState {
  const ProofUploadSuccess({required this.bookingId, required this.message});

  final String bookingId;
  final String message;
}

class ProofUploadError extends ProofUploadState {
  const ProofUploadError(this.message);
  final String message;
}
