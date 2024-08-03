{ ... }:
{
  programs.thunderbird = {
    enable = true;
    settings = {
      # https://superuser.com/a/13551
      "mailnews.wraplength" = 80;
      # 1 = Ascending
      # 2 = Descending
      "mailnews.default_sort_order" = 2;
      # 17 = None
      # 18 = Date
      # 19 = Subject
      # 20 = Author
      # 21 = ID (Order Received)
      # 22 = Thread
      # 23 = Priority
      # 24 = Status
      # 25 = Size
      # 26 = Flagged
      # 27 = Unread
      # 28 = Recipient
      # 29 = Location
      # 30 = Label
      # 31 = Junk Status
      # 32 = Attachments
      # 33 = Account
      # 34 = Custom
      # 35 = Received
      "mailnews.default_sort_type" = 18;
    };
    profiles.nico = {
      isDefault = true;
    };
  };
}
