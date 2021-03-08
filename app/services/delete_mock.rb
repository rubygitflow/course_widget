class DeleteMock
  def self.start(id)
    puts("DeleteMock.start.id = #{id.inspect}")
    Mock.find(id).destroy
  end
end