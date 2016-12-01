export default class Maze {
  constructor(data) {
    this.data = data;
  }

  get links() {
    return this.data.links;
  }

  get x() {
    return this.data.x;
  }

  get y() {
    return this.data.y;
  }
}
