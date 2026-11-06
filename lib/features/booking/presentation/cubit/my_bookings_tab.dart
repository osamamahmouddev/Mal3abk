/// The server's `tab` filter for a player's bookings.
enum MyBookingsTab {
  upcoming('upcoming'),
  pending('pending'),
  completed('completed'),
  cancelled('cancelled');

  const MyBookingsTab(this.query);

  final String query;
}
