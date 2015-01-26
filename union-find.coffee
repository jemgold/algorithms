class QuickFind
  # Costs:
  # Initialize: N
  # Union:      N
  # Find:       1

  # Defect:
  # Union too expensive (n array accesses)
  # Trees are flat but too expensive to keep them flat

  constructor: (count) ->
    @id = [0..count]

  connected: (p, q) ->
    connected = if @id[p] is @id[q] then '✅' else '❌'

    "#{connected}  #{p} #{q}"

  union: (p, q) ->
    pid = @id[p]
    qid = @id[q]

    for _, i in @id
      if @id[i] is pid
        @id[i] = qid
      @id[i]

class QuickUnion
  # Costs:
  # Initialize: N
  # Union:      N
  # Find:       N

  # Defect:
  # Trees can get tall
  # Find too expensive (could be N array accesses)

  constructor: (count) ->
    @id = [0..count]

  root: (i) ->
    while i isnt @id[i]
      i = @id[i]
    i

  connected: (p, q) ->
    connected = if @root(p) is @root(q) then '✅' else '❌'

    "#{connected}  #{p} #{q}"

  union: (p, q) ->
    pRoot = @root(p)
    qRoot = @root(q)
    @id[pRoot] = qRoot

    "#{p}-#{q}"

class Test
  constructor: (klass, length) ->
    console.log klass.name
    @klass = new klass(10)

    @klass.union(1, 2)
    @klass.union(3, 4)
    @klass.union(5, 6)
    @klass.union(7, 8)

    console.log @klass.connected(1, 2)
    console.log @klass.connected(5, 6)
    console.log @klass.connected(1, 8)

    @klass.union(2, 5)
    @klass.union(6, 7)

    console.log @klass.connected(1, 8)

    console.log('-----------\n')

quickFindTest = new Test(QuickFind, 10)
quickUnionTest = new Test(QuickUnion, 10)

