"use client"

import { useState } from "react"
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card"
import { Button } from "@/components/ui/button"
import { Input } from "@/components/ui/input"
import { Badge } from "@/components/ui/badge"
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs"
import { ScrollArea } from "@/components/ui/scroll-area"
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select"
import { Checkbox } from "@/components/ui/checkbox"
import { Label } from "@/components/ui/label"
import { Textarea } from "@/components/ui/textarea"
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar"
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogFooter,
  DialogHeader,
  DialogTitle,
} from "@/components/ui/dialog"
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuLabel,
  DropdownMenuSeparator,
  DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu"
import {
  Search,
  Plus,
  Download,
  Settings,
  Bell,
  Scan,
  Edit3,
  Eye,
  MapPin,
  Clock,
  Camera,
  FileText,
  Save,
  Filter,
  ArrowUpDown,
  Trash2,
  Copy,
  RefreshCw,
  Shield,
  Activity,
  UserPlus,
  MoreVertical,
  LogOut,
  User,
  Lock,
  Unlock,
  AlertTriangle,
  CheckCircle,
  XCircle,
} from "lucide-react"

// User roles and permissions
const USER_ROLES = {
  ADMIN: {
    name: "Administrator",
    permissions: ["all"],
    color: "bg-red-100 text-red-800 border-red-200",
  },
  MANAGER: {
    name: "Manager",
    permissions: ["inventory.read", "inventory.write", "reports.read", "users.read", "stocktake.all"],
    color: "bg-blue-100 text-blue-800 border-blue-200",
  },
  SUPERVISOR: {
    name: "Supervisor",
    permissions: ["inventory.read", "inventory.write", "reports.read", "stocktake.all"],
    color: "bg-green-100 text-green-800 border-green-200",
  },
  STAFF: {
    name: "Staff",
    permissions: ["inventory.read", "stocktake.read", "stocktake.write"],
    color: "bg-gray-100 text-gray-800 border-gray-200",
  },
  VIEWER: {
    name: "Viewer",
    permissions: ["inventory.read", "reports.read"],
    color: "bg-yellow-100 text-yellow-800 border-yellow-200",
  },
}

export default function StockManagementApp() {
  const [activeTab, setActiveTab] = useState("inventory")
  const [searchQuery, setSearchQuery] = useState("")
  const [filterType, setFilterType] = useState("all")
  const [sortBy, setSortBy] = useState("name")
  const [selectedItems, setSelectedItems] = useState<string[]>([])
  const [isAdjustmentModalOpen, setIsAdjustmentModalOpen] = useState(false)
  const [isUserModalOpen, setIsUserModalOpen] = useState(false)
  const [selectedItemForAdjustment, setSelectedItemForAdjustment] = useState<any>(null)
  const [selectedUserForEdit, setSelectedUserForEdit] = useState<any>(null)
  const [adjustmentQuantity, setAdjustmentQuantity] = useState("")
  const [adjustmentReason, setAdjustmentReason] = useState("")
  const [adjustmentNotes, setAdjustmentNotes] = useState("")

  // Current user state
  const [currentUser, setCurrentUser] = useState({
    id: "USR001",
    name: "John Smith",
    email: "john.smith@company.com",
    role: "ADMIN",
    avatar: "/placeholder.svg?height=32&width=32",
    lastLogin: "2025-01-26 14:30:15",
    isActive: true,
  })

  // Users data
  const [users, setUsers] = useState([
    {
      id: "USR001",
      name: "John Smith",
      email: "john.smith@company.com",
      role: "ADMIN",
      avatar: "/placeholder.svg?height=32&width=32",
      lastLogin: "2025-01-26 14:30:15",
      isActive: true,
      createdAt: "2025-01-01 09:00:00",
      department: "IT",
    },
    {
      id: "USR002",
      name: "Sarah Johnson",
      email: "sarah.johnson@company.com",
      role: "MANAGER",
      avatar: "/placeholder.svg?height=32&width=32",
      lastLogin: "2025-01-26 11:15:30",
      isActive: true,
      createdAt: "2025-01-02 10:30:00",
      department: "Operations",
    },
    {
      id: "USR003",
      name: "Mike Wilson",
      email: "mike.wilson@company.com",
      role: "SUPERVISOR",
      avatar: "/placeholder.svg?height=32&width=32",
      lastLogin: "2025-01-26 09:45:22",
      isActive: true,
      createdAt: "2025-01-03 14:15:00",
      department: "Warehouse",
    },
    {
      id: "USR004",
      name: "Emily Davis",
      email: "emily.davis@company.com",
      role: "STAFF",
      avatar: "/placeholder.svg?height=32&width=32",
      lastLogin: "2025-01-25 16:20:10",
      isActive: true,
      createdAt: "2025-01-05 11:00:00",
      department: "Warehouse",
    },
    {
      id: "USR005",
      name: "David Brown",
      email: "david.brown@company.com",
      role: "VIEWER",
      avatar: "/placeholder.svg?height=32&width=32",
      lastLogin: "2025-01-24 13:30:45",
      isActive: false,
      createdAt: "2025-01-10 16:45:00",
      department: "Finance",
    },
  ])

  // Activity tracking data
  const [activities, setActivities] = useState([
    {
      id: "ACT001",
      userId: "USR001",
      userName: "John Smith",
      action: "Stock Adjustment",
      details: "Adjusted Office Paper A4 quantity by +50 units",
      timestamp: "2025-01-26 14:30:15",
      type: "inventory",
      status: "success",
      ipAddress: "192.168.1.100",
      location: "Warehouse A",
    },
    {
      id: "ACT002",
      userId: "USR002",
      userName: "Sarah Johnson",
      action: "User Login",
      details: "Successful login from mobile app",
      timestamp: "2025-01-26 11:15:30",
      type: "auth",
      status: "success",
      ipAddress: "192.168.1.101",
      location: "Office",
    },
    {
      id: "ACT003",
      userId: "USR003",
      userName: "Mike Wilson",
      action: "Stock Take",
      details: "Completed stock count for Electronics section",
      timestamp: "2025-01-26 09:45:22",
      type: "stocktake",
      status: "success",
      ipAddress: "192.168.1.102",
      location: "Electronics Storage",
    },
    {
      id: "ACT004",
      userId: "USR004",
      userName: "Emily Davis",
      action: "Report Export",
      details: "Exported inventory report (PDF)",
      timestamp: "2025-01-25 16:20:10",
      type: "report",
      status: "success",
      ipAddress: "192.168.1.103",
      location: "Office",
    },
    {
      id: "ACT005",
      userId: "USR005",
      userName: "David Brown",
      action: "Failed Login",
      details: "Invalid credentials attempt",
      timestamp: "2025-01-25 08:30:45",
      type: "auth",
      status: "failed",
      ipAddress: "192.168.1.104",
      location: "Remote",
    },
  ])

  // Enhanced sample data
  const stockData = [
    {
      id: "SKU001",
      name: "Office Paper A4 White 80gsm",
      category: "Stationery",
      quantity: 150,
      minStock: 50,
      maxStock: 200,
      price: 12.5,
      location: "Shelf A-1",
      zone: "Warehouse A",
      status: "good",
      barcode: "1234567890123",
      supplier: "Paper Plus Inc",
      lastUpdated: "2025-01-26 14:30",
      reorderPoint: 50,
      unitCost: 10.0,
    },
    {
      id: "SKU002",
      name: "Wireless Optical Mouse",
      category: "Electronics",
      quantity: 8,
      minStock: 15,
      maxStock: 50,
      price: 45.0,
      location: "Shelf B-3",
      zone: "Electronics Storage",
      status: "low",
      barcode: "2345678901234",
      supplier: "Tech Supplies Ltd",
      lastUpdated: "2025-01-26 11:15",
      reorderPoint: 15,
      unitCost: 35.0,
    },
    {
      id: "SKU003",
      name: "Ergonomic Desk Chair Black",
      category: "Furniture",
      quantity: 25,
      minStock: 10,
      maxStock: 40,
      price: 150.0,
      location: "Warehouse C",
      zone: "Furniture Storage",
      status: "good",
      barcode: "3456789012345",
      supplier: "Office Furniture Co",
      lastUpdated: "2025-01-25 16:20",
      reorderPoint: 10,
      unitCost: 120.0,
    },
    {
      id: "SKU004",
      name: "Premium Coffee Beans 1kg",
      category: "Pantry",
      quantity: 3,
      minStock: 20,
      maxStock: 60,
      price: 18.0,
      location: "Kitchen Storage",
      zone: "Pantry Area",
      status: "critical",
      barcode: "4567890123456",
      supplier: "Coffee Direct",
      lastUpdated: "2025-01-25 08:30",
      reorderPoint: 20,
      unitCost: 14.0,
    },
  ]

  // Permission checking function
  const hasPermission = (permission: string) => {
    const userRole = USER_ROLES[currentUser.role as keyof typeof USER_ROLES]
    return userRole.permissions.includes("all") || userRole.permissions.includes(permission)
  }

  // Activity logging function
  const logActivity = (action: string, details: string, type: string, status = "success") => {
    const newActivity = {
      id: `ACT${Date.now()}`,
      userId: currentUser.id,
      userName: currentUser.name,
      action,
      details,
      timestamp: new Date().toLocaleString(),
      type,
      status,
      ipAddress: "192.168.1.100", // In real app, get actual IP
      location: "Mobile App",
    }
    setActivities((prev) => [newActivity, ...prev])
  }

  const getStatusColor = (status: string) => {
    switch (status) {
      case "good":
        return "bg-green-100 text-green-800 border-green-200"
      case "low":
        return "bg-yellow-100 text-yellow-800 border-yellow-200"
      case "critical":
        return "bg-red-100 text-red-800 border-red-200"
      default:
        return "bg-gray-100 text-gray-800 border-gray-200"
    }
  }

  const getActivityIcon = (type: string) => {
    switch (type) {
      case "inventory":
        return <Edit3 className="h-4 w-4" />
      case "auth":
        return <Shield className="h-4 w-4" />
      case "stocktake":
        return <Scan className="h-4 w-4" />
      case "report":
        return <FileText className="h-4 w-4" />
      default:
        return <Activity className="h-4 w-4" />
    }
  }

  const getActivityStatusColor = (status: string) => {
    switch (status) {
      case "success":
        return "text-green-600"
      case "failed":
        return "text-red-600"
      case "warning":
        return "text-yellow-600"
      default:
        return "text-gray-600"
    }
  }

  const filteredStock = stockData.filter((item) => {
    const matchesSearch =
      item.name.toLowerCase().includes(searchQuery.toLowerCase()) ||
      item.category.toLowerCase().includes(searchQuery.toLowerCase()) ||
      item.id.toLowerCase().includes(searchQuery.toLowerCase()) ||
      item.location.toLowerCase().includes(searchQuery.toLowerCase())

    const matchesFilter =
      filterType === "all" ||
      (filterType === "good" && item.status === "good") ||
      (filterType === "low" && item.status === "low") ||
      (filterType === "critical" && item.status === "critical")

    return matchesSearch && matchesFilter
  })

  const sortedStock = [...filteredStock].sort((a, b) => {
    switch (sortBy) {
      case "name":
        return a.name.localeCompare(b.name)
      case "quantity":
        return b.quantity - a.quantity
      case "status":
        return a.status.localeCompare(b.status)
      case "category":
        return a.category.localeCompare(b.category)
      case "location":
        return a.location.localeCompare(b.location)
      default:
        return 0
    }
  })

  const handleSelectAll = () => {
    if (selectedItems.length === sortedStock.length) {
      setSelectedItems([])
    } else {
      setSelectedItems(sortedStock.map((item) => item.id))
    }
  }

  const handleSelectItem = (itemId: string) => {
    setSelectedItems((prev) => (prev.includes(itemId) ? prev.filter((id) => id !== itemId) : [...prev, itemId]))
  }

  const handleAdjustStock = (item: any) => {
    if (!hasPermission("inventory.write")) {
      logActivity("Access Denied", `Attempted to adjust stock for ${item.name}`, "security", "failed")
      return
    }
    setSelectedItemForAdjustment(item)
    setIsAdjustmentModalOpen(true)
  }

  const handleSaveAdjustment = () => {
    if (selectedItemForAdjustment && adjustmentQuantity && adjustmentReason) {
      logActivity(
        "Stock Adjustment",
        `Adjusted ${selectedItemForAdjustment.name} by ${adjustmentQuantity} units - Reason: ${adjustmentReason}`,
        "inventory",
        "success",
      )
      setIsAdjustmentModalOpen(false)
      setAdjustmentQuantity("")
      setAdjustmentReason("")
      setAdjustmentNotes("")
      setSelectedItemForAdjustment(null)
    }
  }

  const handleUserAction = (action: string, user: any) => {
    if (!hasPermission("users.write") && !hasPermission("all")) {
      logActivity("Access Denied", `Attempted to ${action} user ${user.name}`, "security", "failed")
      return
    }

    switch (action) {
      case "edit":
        setSelectedUserForEdit(user)
        setIsUserModalOpen(true)
        break
      case "deactivate":
        setUsers((prev) => prev.map((u) => (u.id === user.id ? { ...u, isActive: false } : u)))
        logActivity("User Deactivated", `Deactivated user account: ${user.name}`, "user", "success")
        break
      case "activate":
        setUsers((prev) => prev.map((u) => (u.id === user.id ? { ...u, isActive: true } : u)))
        logActivity("User Activated", `Activated user account: ${user.name}`, "user", "success")
        break
      case "delete":
        setUsers((prev) => prev.filter((u) => u.id !== user.id))
        logActivity("User Deleted", `Deleted user account: ${user.name}`, "user", "success")
        break
    }
  }

  const handleBulkAction = (action: string) => {
    if (!hasPermission("inventory.write")) {
      logActivity("Access Denied", `Attempted bulk ${action} on ${selectedItems.length} items`, "security", "failed")
      return
    }
    logActivity("Bulk Action", `Performed ${action} on ${selectedItems.length} items`, "inventory", "success")
  }

  return (
    <div className="min-h-screen bg-gray-50">
      {/* Mobile App Container */}
      <div className="max-w-md mx-auto bg-white min-h-screen shadow-xl">
        {/* Header */}
        <div className="bg-slate-900 text-white p-4">
          <div className="flex items-center justify-between mb-2">
            <div className="text-sm opacity-75">11:40</div>
            <div className="flex items-center gap-1 text-sm">
              <div className="w-4 h-2 bg-white rounded-sm opacity-75"></div>
              <div className="text-sm">100%</div>
            </div>
          </div>
          <div className="flex items-center justify-between">
            <div>
              <h1 className="text-xl font-semibold">StockPro</h1>
              <p className="text-sm opacity-75">Professional Inventory Management</p>
            </div>
            <div className="flex items-center gap-2">
              <Button variant="ghost" size="sm" className="text-white hover:bg-slate-800">
                <Bell className="h-4 w-4" />
              </Button>
              <DropdownMenu>
                <DropdownMenuTrigger asChild>
                  <Button variant="ghost" size="sm" className="text-white hover:bg-slate-800 p-1">
                    <Avatar className="h-6 w-6">
                      <AvatarImage src={currentUser.avatar || "/placeholder.svg"} />
                      <AvatarFallback className="text-xs bg-slate-700">
                        {currentUser.name
                          .split(" ")
                          .map((n) => n[0])
                          .join("")}
                      </AvatarFallback>
                    </Avatar>
                  </Button>
                </DropdownMenuTrigger>
                <DropdownMenuContent align="end" className="w-56">
                  <DropdownMenuLabel>
                    <div className="flex flex-col space-y-1">
                      <p className="text-sm font-medium">{currentUser.name}</p>
                      <p className="text-xs text-gray-500">{currentUser.email}</p>
                      <Badge
                        className={`${USER_ROLES[currentUser.role as keyof typeof USER_ROLES].color} text-xs w-fit`}
                      >
                        {USER_ROLES[currentUser.role as keyof typeof USER_ROLES].name}
                      </Badge>
                    </div>
                  </DropdownMenuLabel>
                  <DropdownMenuSeparator />
                  <DropdownMenuItem>
                    <User className="mr-2 h-4 w-4" />
                    Profile
                  </DropdownMenuItem>
                  <DropdownMenuItem>
                    <Settings className="mr-2 h-4 w-4" />
                    Settings
                  </DropdownMenuItem>
                  <DropdownMenuSeparator />
                  <DropdownMenuItem className="text-red-600">
                    <LogOut className="mr-2 h-4 w-4" />
                    Sign Out
                  </DropdownMenuItem>
                </DropdownMenuContent>
              </DropdownMenu>
            </div>
          </div>
        </div>

        {/* Main Content */}
        <div className="flex-1">
          <Tabs value={activeTab} onValueChange={setActiveTab} className="w-full">
            <TabsList className="grid w-full grid-cols-5 bg-gray-100 m-2 rounded-lg">
              <TabsTrigger value="inventory" className="text-xs">
                Inventory
              </TabsTrigger>
              <TabsTrigger value="stocktake" className="text-xs">
                Stock Take
              </TabsTrigger>
              <TabsTrigger
                value="users"
                className="text-xs"
                disabled={!hasPermission("users.read") && !hasPermission("all")}
              >
                Users
              </TabsTrigger>
              <TabsTrigger value="activity" className="text-xs">
                Activity
              </TabsTrigger>
              <TabsTrigger value="settings" className="text-xs">
                Settings
              </TabsTrigger>
            </TabsList>

            {/* Enhanced Inventory Tab */}
            <TabsContent value="inventory" className="p-4 space-y-4">
              {/* Header Controls */}
              <div className="space-y-3">
                <div className="flex items-center justify-between">
                  <h2 className="text-lg font-semibold text-gray-900">Stock Inventory</h2>
                  <div className="text-sm text-gray-600">{sortedStock.length} items</div>
                </div>

                {/* Search and Filter Row */}
                <div className="flex gap-2">
                  <div className="relative flex-1">
                    <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 h-4 w-4 text-gray-400" />
                    <Input
                      placeholder="Search inventory..."
                      value={searchQuery}
                      onChange={(e) => setSearchQuery(e.target.value)}
                      className="pl-10 h-9"
                    />
                  </div>
                  <Select value={filterType} onValueChange={setFilterType}>
                    <SelectTrigger className="w-20 h-9">
                      <Filter className="h-4 w-4" />
                    </SelectTrigger>
                    <SelectContent>
                      <SelectItem value="all">All</SelectItem>
                      <SelectItem value="good">Good</SelectItem>
                      <SelectItem value="low">Low</SelectItem>
                      <SelectItem value="critical">Critical</SelectItem>
                    </SelectContent>
                  </Select>
                  <Select value={sortBy} onValueChange={setSortBy}>
                    <SelectTrigger className="w-20 h-9">
                      <ArrowUpDown className="h-4 w-4" />
                    </SelectTrigger>
                    <SelectContent>
                      <SelectItem value="name">Name</SelectItem>
                      <SelectItem value="quantity">Quantity</SelectItem>
                      <SelectItem value="status">Status</SelectItem>
                      <SelectItem value="category">Category</SelectItem>
                      <SelectItem value="location">Location</SelectItem>
                    </SelectContent>
                  </Select>
                </div>

                {/* Bulk Actions */}
                {selectedItems.length > 0 && hasPermission("inventory.write") && (
                  <div className="flex items-center gap-2 p-2 bg-blue-50 rounded-lg border border-blue-200">
                    <span className="text-sm text-blue-800 font-medium">{selectedItems.length} selected</span>
                    <div className="flex gap-1 ml-auto">
                      <Button
                        size="sm"
                        variant="outline"
                        className="h-7 text-xs bg-transparent"
                        onClick={() => handleBulkAction("export")}
                      >
                        Export
                      </Button>
                      <Button
                        size="sm"
                        variant="outline"
                        className="h-7 text-xs bg-transparent"
                        onClick={() => handleBulkAction("print")}
                      >
                        Print
                      </Button>
                      {hasPermission("inventory.write") && (
                        <Button
                          size="sm"
                          variant="outline"
                          className="h-7 text-xs text-red-600 hover:text-red-700 bg-transparent"
                          onClick={() => handleBulkAction("delete")}
                        >
                          <Trash2 className="h-3 w-3" />
                        </Button>
                      )}
                    </div>
                  </div>
                )}
              </div>

              {/* Inventory Table */}
              <Card className="border-0 shadow-sm">
                <CardContent className="p-0">
                  <div className="overflow-hidden">
                    {/* Table Header */}
                    <div className="bg-gray-50 border-b border-gray-200 px-4 py-3">
                      <div className="grid grid-cols-12 gap-2 text-xs font-semibold text-gray-700 uppercase tracking-wide">
                        {hasPermission("inventory.write") && (
                          <div className="col-span-1 flex items-center">
                            <Checkbox
                              checked={selectedItems.length === sortedStock.length && sortedStock.length > 0}
                              onCheckedChange={handleSelectAll}
                              className="h-3 w-3"
                            />
                          </div>
                        )}
                        <div className={hasPermission("inventory.write") ? "col-span-4" : "col-span-5"}>
                          Item Details
                        </div>
                        <div className="col-span-2 text-center">Stock</div>
                        <div className="col-span-2 text-center">Status</div>
                        <div className="col-span-3 text-center">Actions</div>
                      </div>
                    </div>

                    {/* Table Body */}
                    <ScrollArea className="h-[400px]">
                      <div className="divide-y divide-gray-100">
                        {sortedStock.map((item) => (
                          <div key={item.id} className="px-4 py-3 hover:bg-gray-50 transition-colors">
                            <div className="grid grid-cols-12 gap-2 items-center">
                              {/* Checkbox Column */}
                              {hasPermission("inventory.write") && (
                                <div className="col-span-1">
                                  <Checkbox
                                    checked={selectedItems.includes(item.id)}
                                    onCheckedChange={() => handleSelectItem(item.id)}
                                    className="h-3 w-3"
                                  />
                                </div>
                              )}

                              {/* Item Details Column */}
                              <div className={hasPermission("inventory.write") ? "col-span-4" : "col-span-5"}>
                                <div className="space-y-1">
                                  <h3 className="text-sm font-semibold text-gray-900 leading-tight">{item.name}</h3>
                                  <div className="space-y-0.5">
                                    <p className="text-xs text-gray-600 font-mono">SKU: {item.id}</p>
                                    <p className="text-xs text-gray-500">{item.category}</p>
                                    <p className="text-xs text-gray-500 flex items-center gap-1">
                                      <MapPin className="h-3 w-3" />
                                      {item.location}
                                    </p>
                                  </div>
                                </div>
                              </div>

                              {/* Stock Column */}
                              <div className="col-span-2 text-center">
                                <div className="space-y-1">
                                  <p className="text-lg font-bold text-gray-900">{item.quantity}</p>
                                  <p className="text-xs text-gray-500">Min: {item.minStock}</p>
                                  <div className="w-full bg-gray-200 rounded-full h-1.5">
                                    <div
                                      className={`h-1.5 rounded-full ${
                                        item.quantity <= item.minStock
                                          ? "bg-red-500"
                                          : item.quantity <= item.minStock * 1.5
                                            ? "bg-yellow-500"
                                            : "bg-green-500"
                                      }`}
                                      style={{
                                        width: `${Math.min((item.quantity / (item.minStock * 2)) * 100, 100)}%`,
                                      }}
                                    ></div>
                                  </div>
                                </div>
                              </div>

                              {/* Status Column */}
                              <div className="col-span-2 text-center">
                                <Badge className={`${getStatusColor(item.status)} text-xs px-2 py-1 border`}>
                                  {item.status.toUpperCase()}
                                </Badge>
                                {item.status === "critical" && (
                                  <p className="text-xs text-red-600 mt-1 font-medium">Reorder Now</p>
                                )}
                              </div>

                              {/* Actions Column */}
                              <div className="col-span-3 text-center">
                                <div className="flex justify-center gap-1">
                                  {hasPermission("inventory.write") && (
                                    <Button
                                      variant="ghost"
                                      size="sm"
                                      className="h-7 w-7 p-0 hover:bg-blue-50"
                                      onClick={() => handleAdjustStock(item)}
                                    >
                                      <Edit3 className="h-3 w-3 text-blue-600" />
                                    </Button>
                                  )}
                                  <Button variant="ghost" size="sm" className="h-7 w-7 p-0 hover:bg-green-50">
                                    <Eye className="h-3 w-3 text-green-600" />
                                  </Button>
                                  {hasPermission("inventory.write") && (
                                    <Button variant="ghost" size="sm" className="h-7 w-7 p-0 hover:bg-purple-50">
                                      <Copy className="h-3 w-3 text-purple-600" />
                                    </Button>
                                  )}
                                </div>
                              </div>
                            </div>
                          </div>
                        ))}
                      </div>
                    </ScrollArea>

                    {/* Table Footer with Summary */}
                    <div className="bg-gray-50 border-t border-gray-200 px-4 py-3">
                      <div className="grid grid-cols-12 gap-2 text-sm">
                        <div
                          className={hasPermission("inventory.write") ? "col-span-5" : "col-span-6"}
                          className="font-semibold text-gray-700"
                        >
                          Total: {sortedStock.length} items
                        </div>
                        <div className="col-span-2 text-center font-semibold text-gray-700">
                          {sortedStock.reduce((sum, item) => sum + item.quantity, 0)} Units
                        </div>
                        <div className="col-span-2 text-center">
                          <span className="text-red-600 font-medium">
                            {sortedStock.filter((item) => item.status === "critical").length} Critical
                          </span>
                        </div>
                        <div className="col-span-3 text-center font-semibold text-gray-900">
                          ${sortedStock.reduce((sum, item) => sum + item.price * item.quantity, 0).toFixed(2)}
                        </div>
                      </div>
                    </div>
                  </div>
                </CardContent>
              </Card>
            </TabsContent>

            {/* Stock Take Tab */}
            <TabsContent value="stocktake" className="p-4 space-y-4">
              <div className="space-y-3">
                <div className="flex items-center justify-between">
                  <h2 className="text-lg font-semibold text-gray-900">Stock Take Session</h2>
                  {hasPermission("stocktake.write") && (
                    <Button
                      size="sm"
                      className="h-8"
                      onClick={() => logActivity("Stock Take", "Started new stock take session", "stocktake")}
                    >
                      <Plus className="h-4 w-4 mr-1" />
                      New Session
                    </Button>
                  )}
                </div>

                {/* Stock Take Tools */}
                <div className="grid grid-cols-2 gap-3">
                  <Card className="cursor-pointer hover:shadow-md transition-shadow border-2 border-dashed border-gray-300">
                    <CardContent className="p-4 text-center">
                      <Scan className="h-8 w-8 mx-auto mb-2 text-blue-600" />
                      <p className="text-sm font-medium">Barcode Scanner</p>
                      <p className="text-xs text-gray-600">Quick item lookup</p>
                    </CardContent>
                  </Card>

                  <Card className="cursor-pointer hover:shadow-md transition-shadow border-2 border-dashed border-gray-300">
                    <CardContent className="p-4 text-center">
                      <Camera className="h-8 w-8 mx-auto mb-2 text-green-600" />
                      <p className="text-sm font-medium">Photo Count</p>
                      <p className="text-xs text-gray-600">Visual verification</p>
                    </CardContent>
                  </Card>
                </div>

                {/* Current Session */}
                <Card>
                  <CardHeader className="pb-3">
                    <CardTitle className="text-sm flex items-center gap-2">
                      <Clock className="h-4 w-4" />
                      Current Session
                    </CardTitle>
                  </CardHeader>
                  <CardContent>
                    <div className="space-y-3">
                      <div className="flex justify-between text-sm">
                        <span className="text-gray-600">Started:</span>
                        <span className="font-medium">Today 09:30 AM</span>
                      </div>
                      <div className="flex justify-between text-sm">
                        <span className="text-gray-600">Items Counted:</span>
                        <span className="font-medium">45 / 293</span>
                      </div>
                      <div className="flex justify-between text-sm">
                        <span className="text-gray-600">Discrepancies:</span>
                        <span className="font-medium text-red-600">3 items</span>
                      </div>
                      <div className="w-full bg-gray-200 rounded-full h-2">
                        <div className="bg-blue-600 h-2 rounded-full" style={{ width: "15%" }}></div>
                      </div>
                      {hasPermission("stocktake.write") && (
                        <div className="flex gap-2">
                          <Button variant="outline" size="sm" className="flex-1 bg-transparent">
                            Pause
                          </Button>
                          <Button size="sm" className="flex-1">
                            Continue
                          </Button>
                        </div>
                      )}
                    </div>
                  </CardContent>
                </Card>
              </div>
            </TabsContent>

            {/* Users Management Tab */}
            <TabsContent value="users" className="p-4 space-y-4">
              <div className="space-y-3">
                <div className="flex items-center justify-between">
                  <h2 className="text-lg font-semibold text-gray-900">User Management</h2>
                  {hasPermission("users.write") && (
                    <Button size="sm" className="h-8" onClick={() => setIsUserModalOpen(true)}>
                      <UserPlus className="h-4 w-4 mr-1" />
                      Add User
                    </Button>
                  )}
                </div>

                {/* Users List */}
                <Card>
                  <CardContent className="p-0">
                    <ScrollArea className="h-[500px]">
                      <div className="divide-y divide-gray-100">
                        {users.map((user) => (
                          <div key={user.id} className="p-4 hover:bg-gray-50 transition-colors">
                            <div className="flex items-center gap-3">
                              <Avatar className="h-10 w-10">
                                <AvatarImage src={user.avatar || "/placeholder.svg"} />
                                <AvatarFallback className="bg-gray-200">
                                  {user.name
                                    .split(" ")
                                    .map((n) => n[0])
                                    .join("")}
                                </AvatarFallback>
                              </Avatar>

                              <div className="flex-1 min-w-0">
                                <div className="flex items-center gap-2 mb-1">
                                  <h3 className="text-sm font-semibold text-gray-900 truncate">{user.name}</h3>
                                  {!user.isActive && <XCircle className="h-4 w-4 text-red-500" />}
                                  {user.isActive && <CheckCircle className="h-4 w-4 text-green-500" />}
                                </div>
                                <p className="text-xs text-gray-600 mb-1">{user.email}</p>
                                <div className="flex items-center gap-2 mb-2">
                                  <Badge
                                    className={`${USER_ROLES[user.role as keyof typeof USER_ROLES].color} text-xs px-2 py-1 border`}
                                  >
                                    {USER_ROLES[user.role as keyof typeof USER_ROLES].name}
                                  </Badge>
                                  <span className="text-xs text-gray-500">{user.department}</span>
                                </div>
                                <div className="flex items-center gap-4 text-xs text-gray-500">
                                  <span className="flex items-center gap-1">
                                    <Clock className="h-3 w-3" />
                                    Last login: {user.lastLogin}
                                  </span>
                                </div>
                              </div>

                              {hasPermission("users.write") && (
                                <DropdownMenu>
                                  <DropdownMenuTrigger asChild>
                                    <Button variant="ghost" size="sm" className="h-8 w-8 p-0">
                                      <MoreVertical className="h-4 w-4" />
                                    </Button>
                                  </DropdownMenuTrigger>
                                  <DropdownMenuContent align="end">
                                    <DropdownMenuItem onClick={() => handleUserAction("edit", user)}>
                                      <Edit3 className="mr-2 h-4 w-4" />
                                      Edit
                                    </DropdownMenuItem>
                                    <DropdownMenuItem
                                      onClick={() => handleUserAction(user.isActive ? "deactivate" : "activate", user)}
                                    >
                                      {user.isActive ? (
                                        <>
                                          <Lock className="mr-2 h-4 w-4" />
                                          Deactivate
                                        </>
                                      ) : (
                                        <>
                                          <Unlock className="mr-2 h-4 w-4" />
                                          Activate
                                        </>
                                      )}
                                    </DropdownMenuItem>
                                    <DropdownMenuSeparator />
                                    <DropdownMenuItem
                                      onClick={() => handleUserAction("delete", user)}
                                      className="text-red-600"
                                    >
                                      <Trash2 className="mr-2 h-4 w-4" />
                                      Delete
                                    </DropdownMenuItem>
                                  </DropdownMenuContent>
                                </DropdownMenu>
                              )}
                            </div>
                          </div>
                        ))}
                      </div>
                    </ScrollArea>
                  </CardContent>
                </Card>

                {/* User Stats */}
                <div className="grid grid-cols-4 gap-2">
                  <Card className="border-0 shadow-sm">
                    <CardContent className="p-3 text-center">
                      <p className="text-lg font-bold text-blue-600">{users.length}</p>
                      <p className="text-xs text-gray-600">Total Users</p>
                    </CardContent>
                  </Card>
                  <Card className="border-0 shadow-sm">
                    <CardContent className="p-3 text-center">
                      <p className="text-lg font-bold text-green-600">{users.filter((u) => u.isActive).length}</p>
                      <p className="text-xs text-gray-600">Active</p>
                    </CardContent>
                  </Card>
                  <Card className="border-0 shadow-sm">
                    <CardContent className="p-3 text-center">
                      <p className="text-lg font-bold text-red-600">{users.filter((u) => !u.isActive).length}</p>
                      <p className="text-xs text-gray-600">Inactive</p>
                    </CardContent>
                  </Card>
                  <Card className="border-0 shadow-sm">
                    <CardContent className="p-3 text-center">
                      <p className="text-lg font-bold text-purple-600">
                        {users.filter((u) => u.role === "ADMIN" || u.role === "MANAGER").length}
                      </p>
                      <p className="text-xs text-gray-600">Admins</p>
                    </CardContent>
                  </Card>
                </div>
              </div>
            </TabsContent>

            {/* Activity Tracking Tab */}
            <TabsContent value="activity" className="p-4 space-y-4">
              <div className="space-y-3">
                <div className="flex items-center justify-between">
                  <h2 className="text-lg font-semibold text-gray-900">Activity Log</h2>
                  <div className="text-sm text-gray-600">{activities.length} entries</div>
                </div>

                {/* Activity Filters */}
                <div className="flex gap-2">
                  <Select defaultValue="all">
                    <SelectTrigger className="flex-1 h-9">
                      <SelectValue placeholder="Filter by type" />
                    </SelectTrigger>
                    <SelectContent>
                      <SelectItem value="all">All Activities</SelectItem>
                      <SelectItem value="inventory">Inventory</SelectItem>
                      <SelectItem value="auth">Authentication</SelectItem>
                      <SelectItem value="stocktake">Stock Take</SelectItem>
                      <SelectItem value="report">Reports</SelectItem>
                      <SelectItem value="user">User Management</SelectItem>
                    </SelectContent>
                  </Select>
                  <Select defaultValue="today">
                    <SelectTrigger className="flex-1 h-9">
                      <SelectValue placeholder="Time range" />
                    </SelectTrigger>
                    <SelectContent>
                      <SelectItem value="today">Today</SelectItem>
                      <SelectItem value="week">This Week</SelectItem>
                      <SelectItem value="month">This Month</SelectItem>
                      <SelectItem value="all">All Time</SelectItem>
                    </SelectContent>
                  </Select>
                </div>

                {/* Activity List */}
                <Card>
                  <CardContent className="p-0">
                    <ScrollArea className="h-[450px]">
                      <div className="divide-y divide-gray-100">
                        {activities.map((activity) => (
                          <div key={activity.id} className="p-4 hover:bg-gray-50 transition-colors">
                            <div className="flex items-start gap-3">
                              <div
                                className={`p-2 rounded-full ${getActivityStatusColor(activity.status)} bg-gray-100`}
                              >
                                {getActivityIcon(activity.type)}
                              </div>

                              <div className="flex-1 min-w-0">
                                <div className="flex items-center gap-2 mb-1">
                                  <h3 className="text-sm font-semibold text-gray-900">{activity.action}</h3>
                                  <Badge
                                    className={`text-xs px-2 py-1 ${
                                      activity.status === "success"
                                        ? "bg-green-100 text-green-800"
                                        : activity.status === "failed"
                                          ? "bg-red-100 text-red-800"
                                          : "bg-yellow-100 text-yellow-800"
                                    }`}
                                  >
                                    {activity.status}
                                  </Badge>
                                </div>
                                <p className="text-sm text-gray-600 mb-2">{activity.details}</p>
                                <div className="flex items-center gap-4 text-xs text-gray-500">
                                  <span className="flex items-center gap-1">
                                    <User className="h-3 w-3" />
                                    {activity.userName}
                                  </span>
                                  <span className="flex items-center gap-1">
                                    <Clock className="h-3 w-3" />
                                    {activity.timestamp}
                                  </span>
                                  <span className="flex items-center gap-1">
                                    <MapPin className="h-3 w-3" />
                                    {activity.location}
                                  </span>
                                </div>
                                {activity.status === "failed" && (
                                  <div className="mt-2 p-2 bg-red-50 rounded-lg">
                                    <div className="flex items-center gap-1 text-xs text-red-600">
                                      <AlertTriangle className="h-3 w-3" />
                                      Security Alert: {activity.ipAddress}
                                    </div>
                                  </div>
                                )}
                              </div>
                            </div>
                          </div>
                        ))}
                      </div>
                    </ScrollArea>
                  </CardContent>
                </Card>

                {/* Activity Stats */}
                <div className="grid grid-cols-4 gap-2">
                  <Card className="border-0 shadow-sm">
                    <CardContent className="p-3 text-center">
                      <p className="text-lg font-bold text-green-600">
                        {activities.filter((a) => a.status === "success").length}
                      </p>
                      <p className="text-xs text-gray-600">Success</p>
                    </CardContent>
                  </Card>
                  <Card className="border-0 shadow-sm">
                    <CardContent className="p-3 text-center">
                      <p className="text-lg font-bold text-red-600">
                        {activities.filter((a) => a.status === "failed").length}
                      </p>
                      <p className="text-xs text-gray-600">Failed</p>
                    </CardContent>
                  </Card>
                  <Card className="border-0 shadow-sm">
                    <CardContent className="p-3 text-center">
                      <p className="text-lg font-bold text-blue-600">
                        {activities.filter((a) => a.type === "inventory").length}
                      </p>
                      <p className="text-xs text-gray-600">Inventory</p>
                    </CardContent>
                  </Card>
                  <Card className="border-0 shadow-sm">
                    <CardContent className="p-3 text-center">
                      <p className="text-lg font-bold text-purple-600">
                        {activities.filter((a) => a.type === "auth").length}
                      </p>
                      <p className="text-xs text-gray-600">Auth</p>
                    </CardContent>
                  </Card>
                </div>
              </div>
            </TabsContent>

            {/* Settings Tab */}
            <TabsContent value="settings" className="p-4 space-y-4">
              <div className="space-y-3">
                <h2 className="text-lg font-semibold text-gray-900">Settings</h2>

                {/* User Profile */}
                <Card>
                  <CardHeader className="pb-3">
                    <CardTitle className="text-sm">Profile</CardTitle>
                  </CardHeader>
                  <CardContent>
                    <div className="flex items-center gap-3 mb-4">
                      <Avatar className="h-12 w-12">
                        <AvatarImage src={currentUser.avatar || "/placeholder.svg"} />
                        <AvatarFallback>
                          {currentUser.name
                            .split(" ")
                            .map((n) => n[0])
                            .join("")}
                        </AvatarFallback>
                      </Avatar>
                      <div>
                        <p className="font-semibold">{currentUser.name}</p>
                        <p className="text-sm text-gray-600">{currentUser.email}</p>
                        <Badge
                          className={`${USER_ROLES[currentUser.role as keyof typeof USER_ROLES].color} text-xs mt-1`}
                        >
                          {USER_ROLES[currentUser.role as keyof typeof USER_ROLES].name}
                        </Badge>
                      </div>
                    </div>
                    <Button variant="outline" className="w-full bg-transparent">
                      Edit Profile
                    </Button>
                  </CardContent>
                </Card>

                {/* General Settings */}
                <Card>
                  <CardHeader className="pb-3">
                    <CardTitle className="text-sm">General</CardTitle>
                  </CardHeader>
                  <CardContent className="space-y-3">
                    <div className="flex items-center justify-between">
                      <Label className="text-sm">Auto-sync</Label>
                      <Checkbox />
                    </div>
                    <div className="flex items-center justify-between">
                      <Label className="text-sm">Low stock alerts</Label>
                      <Checkbox defaultChecked />
                    </div>
                    <div className="flex items-center justify-between">
                      <Label className="text-sm">Activity notifications</Label>
                      <Checkbox defaultChecked />
                    </div>
                  </CardContent>
                </Card>

                {/* Security Settings */}
                <Card>
                  <CardHeader className="pb-3">
                    <CardTitle className="text-sm">Security</CardTitle>
                  </CardHeader>
                  <CardContent className="space-y-2">
                    <Button variant="outline" className="w-full justify-start bg-transparent">
                      <Lock className="h-4 w-4 mr-2" />
                      Change Password
                    </Button>
                    <Button variant="outline" className="w-full justify-start bg-transparent">
                      <Shield className="h-4 w-4 mr-2" />
                      Two-Factor Authentication
                    </Button>
                    <Button variant="outline" className="w-full justify-start bg-transparent">
                      <Activity className="h-4 w-4 mr-2" />
                      View Login History
                    </Button>
                  </CardContent>
                </Card>

                {/* Data Management */}
                {hasPermission("all") && (
                  <Card>
                    <CardHeader className="pb-3">
                      <CardTitle className="text-sm">Data Management</CardTitle>
                    </CardHeader>
                    <CardContent className="space-y-2">
                      <Button variant="outline" className="w-full justify-start bg-transparent">
                        <Download className="h-4 w-4 mr-2" />
                        Export All Data
                      </Button>
                      <Button variant="outline" className="w-full justify-start bg-transparent">
                        <RefreshCw className="h-4 w-4 mr-2" />
                        Sync with Server
                      </Button>
                      <Button variant="outline" className="w-full justify-start bg-transparent text-red-600">
                        <Trash2 className="h-4 w-4 mr-2" />
                        Clear Local Data
                      </Button>
                    </CardContent>
                  </Card>
                )}
              </div>
            </TabsContent>
          </Tabs>
        </div>

        {/* Stock Adjustment Modal */}
        <Dialog open={isAdjustmentModalOpen} onOpenChange={setIsAdjustmentModalOpen}>
          <DialogContent className="max-w-sm mx-auto">
            <DialogHeader>
              <DialogTitle className="text-lg">Adjust Stock</DialogTitle>
              <DialogDescription className="text-sm">
                {selectedItemForAdjustment?.name} ({selectedItemForAdjustment?.id})
              </DialogDescription>
            </DialogHeader>
            <div className="space-y-4">
              <div className="space-y-2">
                <Label className="text-sm font-medium">Current Stock</Label>
                <div className="p-2 bg-gray-50 rounded text-sm font-semibold">
                  {selectedItemForAdjustment?.quantity} units
                </div>
              </div>
              <div className="space-y-2">
                <Label className="text-sm font-medium">Adjustment Quantity</Label>
                <Input
                  type="number"
                  placeholder="Enter +/- quantity"
                  value={adjustmentQuantity}
                  onChange={(e) => setAdjustmentQuantity(e.target.value)}
                />
              </div>
              <div className="space-y-2">
                <Label className="text-sm font-medium">Reason</Label>
                <Select value={adjustmentReason} onValueChange={setAdjustmentReason}>
                  <SelectTrigger>
                    <SelectValue placeholder="Select reason" />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="purchase">Purchase/Stock In</SelectItem>
                    <SelectItem value="sale">Sale/Stock Out</SelectItem>
                    <SelectItem value="damaged">Damaged Goods</SelectItem>
                    <SelectItem value="expired">Expired Items</SelectItem>
                    <SelectItem value="count">Stock Count Adjustment</SelectItem>
                    <SelectItem value="other">Other</SelectItem>
                  </SelectContent>
                </Select>
              </div>
              <div className="space-y-2">
                <Label className="text-sm font-medium">Notes (Optional)</Label>
                <Textarea
                  placeholder="Add any additional notes..."
                  value={adjustmentNotes}
                  onChange={(e) => setAdjustmentNotes(e.target.value)}
                  rows={3}
                />
              </div>
            </div>
            <DialogFooter className="flex gap-2">
              <Button variant="outline" onClick={() => setIsAdjustmentModalOpen(false)} className="flex-1">
                Cancel
              </Button>
              <Button onClick={handleSaveAdjustment} className="flex-1">
                <Save className="h-4 w-4 mr-1" />
                Save
              </Button>
            </DialogFooter>
          </DialogContent>
        </Dialog>

        {/* User Management Modal */}
        <Dialog open={isUserModalOpen} onOpenChange={setIsUserModalOpen}>
          <DialogContent className="max-w-sm mx-auto">
            <DialogHeader>
              <DialogTitle className="text-lg">{selectedUserForEdit ? "Edit User" : "Add New User"}</DialogTitle>
              <DialogDescription className="text-sm">
                {selectedUserForEdit ? "Update user information and permissions" : "Create a new user account"}
              </DialogDescription>
            </DialogHeader>
            <div className="space-y-4">
              <div className="space-y-2">
                <Label className="text-sm font-medium">Full Name</Label>
                <Input placeholder="Enter full name" defaultValue={selectedUserForEdit?.name || ""} />
              </div>
              <div className="space-y-2">
                <Label className="text-sm font-medium">Email</Label>
                <Input type="email" placeholder="Enter email address" defaultValue={selectedUserForEdit?.email || ""} />
              </div>
              <div className="space-y-2">
                <Label className="text-sm font-medium">Role</Label>
                <Select defaultValue={selectedUserForEdit?.role || "STAFF"}>
                  <SelectTrigger>
                    <SelectValue placeholder="Select role" />
                  </SelectTrigger>
                  <SelectContent>
                    {Object.entries(USER_ROLES).map(([key, role]) => (
                      <SelectItem key={key} value={key}>
                        {role.name}
                      </SelectItem>
                    ))}
                  </SelectContent>
                </Select>
              </div>
              <div className="space-y-2">
                <Label className="text-sm font-medium">Department</Label>
                <Select defaultValue={selectedUserForEdit?.department || ""}>
                  <SelectTrigger>
                    <SelectValue placeholder="Select department" />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="IT">IT</SelectItem>
                    <SelectItem value="Operations">Operations</SelectItem>
                    <SelectItem value="Warehouse">Warehouse</SelectItem>
                    <SelectItem value="Finance">Finance</SelectItem>
                    <SelectItem value="HR">HR</SelectItem>
                  </SelectContent>
                </Select>
              </div>
              <div className="flex items-center space-x-2">
                <Checkbox id="active" defaultChecked={selectedUserForEdit?.isActive ?? true} />
                <Label htmlFor="active" className="text-sm">
                  Active user account
                </Label>
              </div>
            </div>
            <DialogFooter className="flex gap-2">
              <Button
                variant="outline"
                onClick={() => {
                  setIsUserModalOpen(false)
                  setSelectedUserForEdit(null)
                }}
                className="flex-1"
              >
                Cancel
              </Button>
              <Button
                onClick={() => {
                  logActivity(
                    selectedUserForEdit ? "User Updated" : "User Created",
                    selectedUserForEdit ? `Updated user: ${selectedUserForEdit.name}` : "Created new user account",
                    "user",
                  )
                  setIsUserModalOpen(false)
                  setSelectedUserForEdit(null)
                }}
                className="flex-1"
              >
                <Save className="h-4 w-4 mr-1" />
                {selectedUserForEdit ? "Update" : "Create"}
              </Button>
            </DialogFooter>
          </DialogContent>
        </Dialog>

        {/* Floating Action Button */}
        <Button className="fixed bottom-6 right-6 h-14 w-14 rounded-full shadow-lg" size="icon">
          <Plus className="h-6 w-6" />
        </Button>
      </div>
    </div>
  )
}
