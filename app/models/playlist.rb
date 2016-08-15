class Playlist < ActiveRecord::Base

  belongs_to :admin, class_name: :User
  has_many :listeners, foreign_key: :user_id
  has_many :playlistsongs
  has_many :songs, through: :playlistsongs

  validates :name, :admin_id, :passcode, presence: true
  validates :passcode, uniqueness: true

  # returns an array of all of the songs in arrays of five
  def group_wej_songs
    self.songs.each_slice(5).to_a
  end


  def top_requested_songs
    self.playlistsongs.sort_by {|playlistsong| playlistsong.votes.count}.reverse.each_slice(5).to_a.first
  end

  def generate_passcode
    self.passcode = (0...6).map { ('a'..'z').to_a[rand(26)] }.join.upcase
  end

end
