describe("Rooms",function(){
  describe("formatAvailability",function(){
    it("should return No when false",function(){
      expect(formatAvailability(false)).toEqual("No");
    })
    it("should return Yes when true",function(){
      expect(formatAvailability(true)).toEqual("Yes");
    })
  })
  describe("roomHTML",function(){
    it("should turn room hash into HTML including price for room 2",function(){
      expect(roomHTML(data_mock[1])).toContain("Price per night: £15");
    })
    it("should turn room hash into HTML including owner name for room 3",function(){
      expect(roomHTML(data_mock[2])).toContain("Owner: Owner Room3");
    })
  })
})
